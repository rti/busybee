## Methods

Use these methods on the `CurrentTemplateInfo` object.

`Ancestors`
: (`tpl.CurrentTemplateInfos`) Returns a slice containing information about each template in the current execution chain, starting from the parent of the current template and going up towards the initial template called. It excludes any base template applied via `define` and `block`. You can chain the `Reverse` method to this result to get the slice in chronological execution order.

`Base`
: (`tpl.CurrentTemplateInfoCommonOps`) Returns an object representing the base template that was applied to the current template, if any. This may be `nil`.

`Filename`
: (`string`) Returns the absolute path of the current template. This will be empty for embedded templates.

`Name`
: (`string`) Returns the name of the current template. This is usually the path relative to the layouts directory.

`Parent`
: (`tpl.CurrentTemplateInfo`) Returns an object representing the parent of the current template, if any. This may be `nil`.

