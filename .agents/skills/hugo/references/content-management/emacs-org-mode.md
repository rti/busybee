## Emacs Org Mode

If your [content format][] is [Emacs Org Mode][], you may provide front matter using Org Mode keywords. For example:

```text {file="content/example.org"}
#+TITLE: Example
#+DATE: 2024-02-02T04:14:54-08:00
#+DRAFT: false
#+AUTHOR: John Smith
#+GENRES: mystery
#+GENRES: romance
#+TAGS: red
#+TAGS: blue
#+WEIGHT: 10
```

Note that you can also specify array elements on a single line:

```text {file="content/example.org"}
#+TAGS[]: red blue
```

