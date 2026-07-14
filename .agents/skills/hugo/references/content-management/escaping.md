## Escaping

When documenting shortcode usage, escape the tag delimiters:

````md {file="content/example.md"}
```text {linenos=inline}
{{</*/* shortcode-1 */*/>}}

{{%/*/* shortcode-2 */*/%}}
```
````

Hugo renders this to:

```text {linenos=inline}
{{</* shortcode-1 */>}}

{{%/* shortcode-2 */%}}
```

