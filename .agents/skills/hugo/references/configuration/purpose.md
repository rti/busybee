## Purpose

Hugo uses file caches to store data on disk, avoiding repeated operations within the same build and persisting data from one build to the next.

`assets`
: Caches processed CSS and Sass resources.

`getresource`
: Caches files fetched from remote URLs via the [`resources.GetRemote`][] function.

`images`
: Caches processed images.

`misc`
: Caches miscellaneous data.

`modulegitinfo`
: Caches Git information for modules.

`modulequeries`
: Caches the results of module resolution queries.

`modules`
: Caches downloaded modules.

