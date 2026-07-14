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
SKIP_PATTERN="(_index|LICENSE|CLAUDE|AGENTS|documentation)\.md$"

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
  jq --arg prefix "$DOCS_PREFIX/" --arg skip "$SKIP_PATTERN" '
    [.tree[] |
     select(.path | startswith($prefix)) |
     select(.path | test("\\.md$")) |
     (.path | ltrimstr($prefix)) as $rel |
     select($rel | split("/")[0] | test("^_") | not) |
     select($rel | split("/")[-1] | test($skip) | not) |
     {
       path: .path,
       rel: $rel,
       topic: ($rel | split("/")[0]),
       subtopic: ($rel | split("/") | if length > 2 then .[1:-1] | join("/") else "__FLAT__" end)
     }
    ]' > "$CACHE_DIR/docs.json"

TOTAL=$(jq 'length' "$CACHE_DIR/docs.json")
echo "  Found $TOTAL documentation files."

# --- Step 2: Download all files ---
echo ""
echo "[2/4] Downloading content..."

rm -rf "$REFS_DIR"
mkdir -p "$REFS_DIR" "$CACHE_DIR/downloads"

jq -r '.[].path' "$CACHE_DIR/docs.json" > "$CACHE_DIR/paths.txt"

download_count=0
while IFS= read -r filepath; do
  raw_url="https://raw.githubusercontent.com/$REPO/$BRANCH/$filepath"
  # Cache key: replace / with _ to flatten path
  cache_key=$(echo "$filepath" | sed "s|${DOCS_PREFIX}/||" | tr '/' '_')
  cache_file="$CACHE_DIR/downloads/${cache_key}"

  if curl -sfL --max-time 30 "$raw_url" -o "$cache_file" 2>/dev/null; then
    sed -i '/^---$/,/^---$/d' "$cache_file"
    download_count=$((download_count + 1))
  else
    echo "  WARNING: Failed to download $filepath" >&2
  fi
done < "$CACHE_DIR/paths.txt"

echo "  Downloaded $download_count files."

# --- Step 3: Organize into reference files ---
echo ""
echo "[3/4] Organizing reference files..."

# Use process substitution to avoid subshell problem
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

ref_count=$(find "$REFS_DIR" -name '*.md' | wc -l)
flat_count=$(find "$REFS_DIR" -maxdepth 1 -name '*.md' | wc -l)
echo "  Created $ref_count reference files ($flat_count flat, rest in subdirectories)."

# --- Step 4: Generate SKILL.md ---
echo ""
echo "[4/4] Generating SKILL.md..."

to_title() {
  echo "$1" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1'
}

# Build topic index from actual reference files
TOPICS_MD=""

# First: topics with subdirectories
for topic_dir in "$REFS_DIR"/*/; do
  [ -d "$topic_dir" ] || continue
  topic=$(basename "$topic_dir")
  display=$(to_title "$topic")

  TOPICS_MD+="### \`$topic\` — $display\n\n"
  for ref_file in "$topic_dir"*.md; do
    [ -f "$ref_file" ] || continue
    subname=$(basename "$ref_file" .md)
    subdisplay=$(to_title "$subname")
    TOPICS_MD+="- [\`$subname\`](references/$topic/$subname.md) — $subdisplay\n"
  done
  TOPICS_MD+="\n"
done

# Then: flat topic files (no subdirectories)
for topic_file in "$REFS_DIR"/*.md; do
  [ -f "$topic_file" ] || continue
  topic=$(basename "$topic_file" .md)
  display=$(to_title "$topic")
  TOPICS_MD+="- [\`$topic\`](references/$topic.md) — $display\n"
done

cat > "$SKILL_DIR/SKILL.md" << 'HEADER'
---
name: hugo
description: Hugo static site generator reference. Use when working with Hugo sites, configuring Hugo, writing templates, using Hugo functions/methods, or building static websites with Hugo. Covers configuration, content management, templates, functions, deployment, and more.
license: MIT
source: https://github.com/gohugoio/hugo/tree/master/docs
metadata:
  generated_by: generate-hugo-skill.sh
  hugo_docs_branch: master
  source_repo: gohugoio/hugo
---

# Hugo Static Site Generator

Hugo is the world's fastest framework for building websites. It is a static site generator written in Go, known for its speed and flexibility.

## Overview

This skill provides comprehensive reference material from the official Hugo documentation. The SKILL.md file serves as an index — load specific reference files for detailed information on individual topics.

## Topic Index

HEADER

echo -e "$TOPICS_MD" >> "$SKILL_DIR/SKILL.md"

cat >> "$SKILL_DIR/SKILL.md" << 'FOOTER'

## Usage with Hugo Sites

### Common Commands

```bash
hugo new site <name>       # Create a new site
hugo new <section>/<name>  # Create a new content page
hugo                      # Build the site
hugo server               # Run development server
hugo server -D            # Include draft content
hugo --minify             # Build with minification
```

### Typical Project Structure

```
my-site/
├── archetypes/       # Default front matter templates
├── assets/           # Source assets (SCSS, JS, images)
├── content/          # Markdown content files
├── data/             # Data files (JSON, YAML, TOML)
├── layouts/          # HTML templates
├── static/           # Static files (copied as-is)
├── themes/           # Hugo themes
├── config.toml       # Site configuration
└── go.mod            # Hugo modules (optional)
```

### Working with This Skill

1. **Quick lookup**: Read SKILL.md to find the relevant topic area
2. **Deep dive**: Load the corresponding `references/<topic>.md` or `references/<topic>/<subtopic>.md` file
3. **Functions reference**: The `functions/` and `methods/` references are organized by package (e.g., strings, collections, urls)

## Best Practices

- Keep SKILL.md under 500 lines for fast loading
- Reference files contain the actual Hugo docs content — load only what you need
- Function and method references are split by package to keep files small
FOOTER

skill_lines=$(wc -l < "$SKILL_DIR/SKILL.md")
total_size=$(du -sh "$SKILL_DIR" | cut -f1)

echo ""
echo "=== Done! ==="
echo "SKILL.md: $skill_lines lines"
echo "References: $ref_count files ($flat_count flat)"
echo "Total size: $total_size"
