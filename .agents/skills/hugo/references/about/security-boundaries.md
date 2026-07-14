## Security Boundaries

- The templates inside `layouts` are trusted.
- The assets inside `archetypes`, `assets`, `resources`, `data`, `i18n` and `static` are trusted.
- The content and the content produced by [content adapters][] inside `content` is not trusted. The one exception here is if [inline shortcodes][] is enabled. Note that for content adapters, this is scoped to the result of the adapter.
- The development server, `hugo server`, and its livereload script is trusted and meant for _local_ development only.

