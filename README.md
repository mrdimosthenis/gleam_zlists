# gleam_zlists

A library for working with **lazy lists** in **Gleam**.

It is a wrapper for [vjache/erlang-zlists](https://github.com/vjache/erlang-zlists), enriched with more functions.

The documentation is available on [HexDocs](https://hexdocs.pm/gleam_zlists/gleam_zlists.html).

## Installation

Add `gleam_zlists` to your Gleam project.

```
gleam add gleam_zlists
```

## Examples

```gleam
import gleam_zlists as zlist

[2, 4, 6]
|> zlist.of_list
|> zlist.all(int.is_even)
// True

[1, 2, 3]
|> zlist.of_list
|> zlist.reverse
|> zlist.to_list
// [3, 2, 1]

["a", "b", "c"]
|> zlist.of_list
|> zlist.with_index
|> zlist.to_list
// [#("a", 0), #("b", 1), #("c", 2)]
```
