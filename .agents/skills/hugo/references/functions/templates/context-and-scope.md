## Context and scope

When using decorators, the `with` statement creates a new [scope](g). Variables defined outside the with block in the calling template are not automatically available inside the captured block.

By passing a context to `templates.Inner`, you ensure that the injected content has access to the correct data even when nested inside multiple layers of wrappers. This is critical when the decorator is used inside a loop or a specific data overlay.

