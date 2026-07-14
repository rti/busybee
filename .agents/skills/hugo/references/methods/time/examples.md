## Examples

Given this front matter:

{{< code-toggle fm=true >}}
title = "About time"
date = 2023-01-27T23:44:58-08:00
{{< /code-toggle >}}

The examples below were rendered in the `America/Los_Angeles` time zone:

Format string|Result
:--|:--
`Monday, January 2, 2006`|`Friday, January 27, 2023`
`Mon Jan 2 2006`|`Fri Jan 27 2023`
`January 2006`|`January 2023`
`2006-01-02`|`2023-01-27`
`Monday`|`Friday`
`02 Jan 06 15:04 MST`|`27 Jan 23 23:44 PST`
`Mon, 02 Jan 2006 15:04:05 MST`|`Fri, 27 Jan 2023 23:44:58 PST`
`Mon, 02 Jan 2006 15:04:05 -0700`|`Fri, 27 Jan 2023 23:44:58 -0800`

