## Arguments

`id`
: (`string`) The video `id`. Optional if the `id` is the first and only positional argument.

`allowFullScreen`
: (`bool`) Whether the `iframe` element can activate full screen mode. Default is `true`.

`autoplay`
: (`bool`) Whether to automatically play the video. Forces `mute` to `true`. Default is `false`.

`class`
: (`string`) The `class` attribute of the wrapping `div` element. When specified, removes the `style` attributes from the `iframe` element and its wrapping `div` element.

`controls`
: (`bool`) Whether to display the video controls. Default is `true`.

`end`
: (`int`) The time, measured in seconds from the start of the video, when the player should stop playing the video.

`loading`
: (`string`) The loading attribute of the `iframe` element, either `eager` or `lazy`. Default is `eager`.

`loop`
: (`bool`) Whether to indefinitely repeat the video. Ignores the `start` and `end` arguments after the first play. Default is `false`.

`mute`
: (`bool`) Whether to mute the video. Always `true` when `autoplay` is `true`. Default is `false`.

`start`
: (`int`) The time, measured in seconds from the start of the video, when the player should start playing the video.

`title`
: (`string`) The `title` attribute of the `iframe` element. Defaults to "YouTube video".

Here's an example using some of the available arguments:

```md
{{</* youtube id=0RKpf3rK57I start=30 end=60 loading=lazy */>}}
```

