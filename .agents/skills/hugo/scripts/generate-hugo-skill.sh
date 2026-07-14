#!/usr/bin/env bash
set -euo pipefail

# generate-hugo-skill.sh
# Generates a hierarchical Agent Skill for Hugo from the official Hugo docs.
# Re-run to update with latest Hugo docs.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REFS_DIR="$SKILL_DIR/references"
CACHE_DIR=$(mktemp -d)
trap 'rm -rf "$CACHE_DIR"' EXIT

REPO="gohugoio/hugo"
BRANCH="master"
DOCS_PREFIX="docs/content/en"
SKIP_PATTERN="(installation|external-learning-resources|glossary|_index|LICENSE|CLAUDE|AGENTS|documentation)\.md$"
SKIP_TOPICS="^host-and-deploy"

echo "=== Hugo Skill Generator ==="
echo "Skill directory: $SKILL_DIR"

# --- Step 1: Fetch recursive git tree and extract doc file list ---
echo ""
echo "[1/4] Fetching Hugo docs tree..."

TREE_SHA=$(curl -sf "https://api.github.com/repos/$REPO/git/ref/heads/$BRANCH" | jq -r '.object.sha')
if [ -z "$TREE_SHA" ]; then
  echo "ERROR: Could not fetch tree SHA" >&2
  exit 1
fi

curl -sfL "https://api.github.com/repos/$REPO/git/trees/$TREE_SHA?recursive=1" | \
  jq --arg prefix "$DOCS_PREFIX/" --arg skip "$SKIP_PATTERN" --arg skip_topics "$SKIP_TOPICS" '
    [.tree[] |
      select(.path | startswith($prefix)) |
      select(.path | test("\\.md$")) |
      (.path | ltrimstr($prefix)) as $rel |
      select($rel | split("/")[0] | test("^_") | not) |
      select($rel | split("/")[-1] | test($skip) | not) |
      select($rel | test($skip_topics) | not) |
      {
        path: .path,
        rel: $rel,
        topic: ($rel | split("/")[0]),
        subtopic: ($rel | split("/") | if length > 2 then .[1:-1] | join("/") else "__FLAT__" end)
      }
    ]' > "$CACHE_DIR/docs.json"

TOTAL=$(jq 'length' "$CACHE_DIR/docs.json")
echo "  Found $TOTAL documentation files."

# --- Step 2: Download all files (parallelized, 6 concurrent) ---
echo ""
echo "[2/4] Downloading content..."

rm -rf "$REFS_DIR"
mkdir -p "$REFS_DIR" "$CACHE_DIR/downloads"

jq -r '.[].path' "$CACHE_DIR/docs.json" > "$CACHE_DIR/paths.txt"

MAX_PARALLEL=6
active_jobs=0

download_count=0
fail_count=0
pids=()

while IFS= read -r filepath; do
  raw_url="https://raw.githubusercontent.com/$REPO/$BRANCH/$filepath"
  cache_key=$(echo "$filepath" | sed "s|${DOCS_PREFIX}/||" | tr '/' '_')
  cache_file="$CACHE_DIR/downloads/${cache_key}"

  (
    if curl -sfL --max-time 30 "$raw_url" -o "$cache_file" 2>/dev/null; then
      sed -i '/^---$/,/^---$/d' "$cache_file"
      echo "OK:$filepath"
    else
      echo "FAIL:$filepath"
    fi
  ) >> "$CACHE_DIR/download_results.txt" &
  pids+=($!)

  active_jobs=$((active_jobs + 1))
  if [ "$active_jobs" -ge "$MAX_PARALLEL" ]; then
    wait -n 2>/dev/null || true
    active_jobs=$((active_jobs - 1))
  fi
done < "$CACHE_DIR/paths.txt"

wait

while IFS= read -r result; do
  status="${result%%:*}"
  if [ "$status" = "OK" ]; then
    download_count=$((download_count + 1))
  else
    fail_count=$((fail_count + 1))
    echo "  WARNING: Failed to download ${result#*:}" >&2
  fi
done < "$CACHE_DIR/download_results.txt"

echo "  Downloaded $download_count files ($fail_count failed)."

# --- Step 3: Organize into reference files ---
echo ""
echo "[3/4] Organizing reference files..."

while IFS=$'\t' read -r _rel topic subtopic orig_path; do
  cache_key=$(echo "$orig_path" | sed "s|${DOCS_PREFIX}/||" | tr '/' '_')
  cache_file="$CACHE_DIR/downloads/${cache_key}"
  [ -f "$cache_file" ] || continue

  if [ "$subtopic" = "__FLAT__" ]; then
    ref_file="$REFS_DIR/${topic}.md"
  else
    ref_file="$REFS_DIR/${topic}/${subtopic}.md"
  fi

  mkdir -p "$(dirname "$ref_file")"

  {
    echo ""
    echo "---"
    echo "source: https://github.com/$REPO/blob/$BRANCH/$orig_path"
    echo "---"
    echo ""
    cat "$cache_file"
    echo ""
  } >> "$ref_file"
done < <(jq -r '.[] | "\(.rel)\t\(.topic)\t\(.subtopic)\t\(.path)"' "$CACHE_DIR/docs.json")

# --- Step 3b: Split large files (>200 lines) by headlines ---
echo ""
echo "[3b/4] Splitting large files..."

to_slug() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g; s/  */ /g; s/ /-/g; s/-$//; s/--*/-/g'
}

to_display() {
  echo "$1" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1'
}

split_count=0
while IFS= read -r ref_file; do
  line_count=$(wc -l < "$ref_file")
  [ "$line_count" -le 200 ] && continue

  headline_count=$(grep -c '^## ' "$ref_file" || true)
  [ "$headline_count" -eq 0 ] && continue

  dir=$(dirname "$ref_file")
  base=$(basename "$ref_file" .md)
  split_dir="$dir/${base}"
  mkdir -p "$split_dir"

  mapfile -t hlines < <(grep -n '^## ' "$ref_file" | cut -d: -f1)
  mapfile -t htitles < <(grep '^## ' "$ref_file" | sed 's/^## //')

  total_sections=${#hlines[@]}
  first_hline="${hlines[0]}"
  intro_lines=$((first_hline - 1))

  # Create index.md
  index_path="$split_dir/index.md"
  {
    echo "# $base"
    echo ""
  } > "$index_path"

  # Add intro content to index if present
  if [ "$intro_lines" -gt 0 ]; then
    sed -n "1,${intro_lines}p" "$ref_file" >> "$index_path"
    echo "" >> "$index_path"
  fi

  echo "## Sections" >> "$index_path"
  echo "" >> "$index_path"

  # Split each section
  for i in "${!hlines[@]}"; do
    start_line="${hlines[$i]}"
    title="${htitles[$i]}"
    slug=$(to_slug "$title")
    display=$(to_display "$title")

    if [ $((i + 1)) -lt "$total_sections" ]; then
      end_line=$(( ${hlines[$((i + 1))]} - 1 ))
    else
      end_line="$line_count"
    fi

    section_file="$split_dir/${slug}.md"
    sed -n "${start_line},${end_line}p" "$ref_file" > "$section_file"

    rel_path="${split_dir#"${SKILL_DIR}"/}"
    echo "- [\`${slug}\`](${rel_path}/${slug}.md) — ${display}" >> "$index_path"
  done

  echo "" >> "$index_path"

  # Replace original file with redirect
  {
    echo "# $base"
    echo ""
    rel_ref="${split_dir#"${SKILL_DIR}"/}"
    echo "This topic has been split into sub-sections. See [index](references/${rel_ref}/index.md) for navigation."
  } > "$ref_file"

  split_count=$((split_count + 1))
done < <(find "$REFS_DIR" -name '*.md' -not -name 'index.md')

echo "  Split $split_count large files."

ref_count=$(find "$REFS_DIR" -name '*.md' | wc -l)
flat_count=$(find "$REFS_DIR" -maxdepth 1 -name '*.md' | wc -l)
echo "  Total reference files: $ref_count ($flat_count flat)."

# --- Step 4: Generate SKILL.md ---
echo ""
echo "[4/4] Generating SKILL.md..."

to_title() {
  echo "$1" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1'
}

TOPICS_MD=""

# Topics with subdirectories (split topics) — only link to index.md
for topic_dir in "$REFS_DIR"/*/; do
  [ -d "$topic_dir" ] || continue
  topic=$(basename "$topic_dir")
  display=$(to_title "$topic")

  if [ -f "$topic_dir/index.md" ]; then
    TOPICS_MD+="### \`$topic\` — $display\n"
    TOPICS_MD+="- [\`index\`](references/$topic/index.md) — Overview\n"
    TOPICS_MD+="\n"
  fi

  # For functions/, methods/, and contribute/, list subtopic indexes
  if [ "$topic" = "functions" ] || [ "$topic" = "methods" ] || [ "$topic" = "contribute" ]; then
    for sub_dir in "$topic_dir"*/; do
      [ -d "$sub_dir" ] || continue
      subtopic=$(basename "$sub_dir")
      subdisplay=$(to_title "$subtopic")
      if [ -f "$sub_dir/index.md" ]; then
        TOPICS_MD+="### \`$topic/$subtopic\` — $subdisplay\n"
        TOPICS_MD+="- [\`index\`](references/$topic/$subtopic/index.md) — Overview\n"
        TOPICS_MD+="\n"
      fi
    done
  fi

  # List non-split sub-files (e.g. content-management/image-processing.md)
  for ref_file in "$topic_dir"*.md; do
    [ -f "$ref_file" ] || continue
    subname=$(basename "$ref_file" .md)
    [ "$subname" = "index" ] && continue
    [ -d "$topic_dir/$subname" ] && continue
    subdisplay=$(to_title "$subname")
    TOPICS_MD+="### \`$topic/$subname\` — $subdisplay\n"
    TOPICS_MD+="- [\`$subname\`](references/$topic/$subname.md) — $subdisplay\n"
    TOPICS_MD+="\n"
  done
done

# Flat files (no corresponding subdirectory = not split)
for topic_file in "$REFS_DIR"/*.md; do
  [ -f "$topic_file" ] || continue
  topic=$(basename "$topic_file" .md)
  [ -d "$REFS_DIR/$topic" ] && continue
  display=$(to_title "$topic")
  TOPICS_MD+="### \`$topic\` — $display\n"
  TOPICS_MD+="- [\`$topic\`](references/$topic.md) — $display\n"
  TOPICS_MD+="\n"
done

cat > "$SKILL_DIR/SKILL.md" << 'HEADER'
---
name: hugo
description: Hugo static site generator reference. Use when working with Hugo sites, configuring Hugo, writing templates, using Hugo functions/methods, or building static websites with Hugo. Covers configuration, content management, templates, functions, and more.
license: MIT
source: https://github.com/gohugoio/hugo/tree/master/docs
metadata:
  generated_by: generate-hugo-skill.sh
  hugo_docs_branch: master
  source_repo: gohugoio/hugo
---

# Hugo Static Site Generator

Hugo is the world's fastest framework for building static websites. Written in Go, it combines speed with flexibility.

## Overview

This skill provides reference material from the official Hugo documentation. Each topic links to an index file that lists available sub-sections. Load specific reference files for detailed information.

## Topic Index

HEADER

echo -e "$TOPICS_MD" >> "$SKILL_DIR/SKILL.md"

cat >> "$SKILL_DIR/SKILL.md" << 'FOOTER'

## Common Commands

```bash
hugo new site <name>       # Create a new site
hugo new <section>/<name>  # Create new content
hugo                      # Build the site
hugo server               # Development server
hugo server -D            # Include drafts
hugo --minify             # Minified build
```

## Working with This Skill

1. **Quick lookup**: Read SKILL.md to find the relevant topic
2. **Deep dive**: Load the `references/<topic>/index.md` for sub-sections, then individual section files
3. **Functions/methods**: Organized by package (e.g., strings, collections, urls)
FOOTER

skill_lines=$(wc -l < "$SKILL_DIR/SKILL.md")
total_size=$(du -sh "$SKILL_DIR" | cut -f1)

echo ""
echo "=== Done! ==="
echo "SKILL.md: $skill_lines lines"
echo "References: $ref_count files ($flat_count flat)"
echo "Total size: $total_size"
