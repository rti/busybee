## Methods

Use these methods on the data structure.

`Set`
: Sets the value of the given key.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  ```

`Get`
: (`any`) Gets the value of the given key.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  {{ hugo.Store.Get "greeting" }} → Hello
  ```

`Add`
: Adds the given value to the existing value(s) of the given key.

  For single values, `Add` accepts values that support Go's `+` operator. If the first `Add` for a key is an array or slice, the following adds will be appended to that list.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  {{ hugo.Store.Add "greeting" "Welcome" }}
  {{ hugo.Store.Get "greeting" }} → HelloWelcome
  ```

  ```go-html-template
  {{ hugo.Store.Set "total" 3 }}
  {{ hugo.Store.Add "total" 7 }}
  {{ hugo.Store.Get "total" }} → 10
  ```

  ```go-html-template
  {{ hugo.Store.Set "greetings" (slice "Hello") }}
  {{ hugo.Store.Add "greetings" (slice "Welcome" "Cheers") }}
  {{ hugo.Store.Get "greetings" }} → [Hello Welcome Cheers]
  ```

`SetInMap`
: Takes a `key`, `mapKey` and `value` and adds a map of `mapKey` and `value` to the given `key`.

  ```go-html-template
  {{ hugo.Store.SetInMap "greetings" "english" "Hello" }}
  {{ hugo.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ hugo.Store.Get "greetings" }} → map[english:Hello french:Bonjour]
  ```

`DeleteInMap`
: Takes a `key` and `mapKey` and removes the map of `mapKey` from the given `key`.

  ```go-html-template
  {{ hugo.Store.SetInMap "greetings" "english" "Hello" }}
  {{ hugo.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ hugo.Store.DeleteInMap "greetings" "english" }}
  {{ hugo.Store.Get "greetings" }} → map[french:Bonjour]
  ```

`GetSortedMapValues`
: (`[]any`) Returns an array of values from `key` sorted by `mapKey`.

  ```go-html-template
  {{ hugo.Store.SetInMap "greetings" "english" "Hello" }}
  {{ hugo.Store.SetInMap "greetings" "french" "Bonjour" }}
  {{ hugo.Store.GetSortedMapValues "greetings" }} → [Hello Bonjour]
  ```

`Delete`
: Removes the given key.

  ```go-html-template
  {{ hugo.Store.Set "greeting" "Hello" }}
  {{ hugo.Store.Delete "greeting" }}
  ```

{{% include "_common/store-scope.md" %}}

