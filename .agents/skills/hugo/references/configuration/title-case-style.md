## Title case style

Hugo's [`titleCaseStyle`](#titlecasestyle) setting governs capitalization for automatically generated section titles and the [`strings.Title`][] function. By default, it follows the capitalization rules published in the Associated Press Stylebook. Change this setting to use other capitalization rules.

`ap`
: Use the capitalization rules published in the [Associated Press Stylebook][]. This is the default.

`chicago`
: Use the capitalization rules published in the [Chicago Manual of Style][].

`go`
: Capitalize the first letter of every word.

`firstupper`
: Capitalize the first letter of the first word.

`none`
: Disable transformation of automatic section titles, and disable the transformation performed by the `strings.Title` function. This is useful if you would prefer to manually capitalize section titles as needed, and to bypass opinionated theme usage of the `strings.Title` function.

