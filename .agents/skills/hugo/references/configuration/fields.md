## Fields

`kind`
: (`string`) A [glob pattern](g) matching the [page kind](g). For example: `{taxonomy,term}`.

`lang`
: {{< deprecated-in 0.153.0 />}}
: Use [`sites`](#sites) instead.

`output`
: (`string`) A [glob pattern](g) matching the [output format](g) of the page. For example: `{html,json}`.

`path`
: (`string`) A [glob pattern](g) matching the page's [logical path](g). For example: `{/books,/books/**}`.

`sites`
: {{< new-in 0.153.0 />}}
: (`map`) A map to define [sites matrix](g).

