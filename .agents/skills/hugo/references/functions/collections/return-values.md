## Return values

Condition|Return value
:--|:--|:--
`N <= HIGH`|A sorted random sample of size `N` using J. S. Vitter's [Method D][] for sequential random sampling
`N > HIGH`|The full, sorted range `[0, HIGH)` of size `HIGH`
`N == 0`|An empty slice
`N < 0`|Error
`N > 10^6`|Error
`HIGH == 0`|An empty slice
`HIGH < 0`|Error
`HIGH > 10^6`|Error
`SEED < 0`|Error
{.no-wrap-first-col}

