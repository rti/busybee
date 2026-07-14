## Open-source

[Pagefind][]
: A fully static search library that aims to perform well on large sites, while using as little of your users' bandwidth as possible.

[GitHub Gist for Hugo Workflow][]
: This gist contains a simple workflow to create a search index for your static website. It uses a simple Grunt script to index all your content files and [lunr.js][] to serve the search results.

[hugo-lunr][]
: A simple way to add site search to your static Hugo site using [lunr.js][]. Hugo-lunr will create an index file of any HTML and Markdown documents in your Hugo project.

[hugo-lunr-zh][]
: A bit like Hugo-lunr, but Hugo-lunr-zh can help you separate the Chinese keywords.

[GitHub Gist for Fuse.js integration][]
: This gist demonstrates how to leverage Hugo's existing build time processing to generate a searchable JSON index used by [Fuse.js][] on the client side. Although this gist uses Fuse.js for fuzzy matching, any client-side search tool capable of reading JSON indexes will work. Does not require npm, grunt, or other build-time tools except Hugo!

[hugo-search-index][]
: A library containing Gulp tasks and a prebuilt browser script that implements search. Gulp generates a search index from project Markdown files.

[hugofastsearch][]
: A usability and speed update to "GitHub Gist for Fuse.js integration" — global, keyboard-optimized search.

[JS & Fuse.js tutorial][]
: A simple client-side search solution, using FuseJS (does not require jQuery).

[Hugo Lyra][]
: Hugo-Lyra is a JavaScript module to integrate [Lyra][] into a Hugo website. It contains the server-side part to generate the index and the client-side library (optional) to bootstrap the search engine easily.

[INFINI Pizza for WebAssembly][]
: Pizza is a super-lightweight yet fully featured search engine written in Rust. You can quickly add offline search functionality to your Hugo website in just five minutes with only three lines of code. For a step-by-step guide on integrating it with Hugo, check out [this blog tutorial][].

