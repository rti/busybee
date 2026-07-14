## Create a media type

You can create new media types as needed. For example, to create a media type for an Atom feed:

{{< code-toggle file=hugo >}}
[mediaTypes.'application/atom+xml']
suffixes = ['atom']
{{< /code-toggle >}}

