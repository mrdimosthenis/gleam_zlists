# gleam_zlists

A library for working with **lazy lists** in **Gleam**.

It is a wrapper for [vjache/erlang-zlists](https://github.com/vjache/erlang-zlists), enriched with more functions.

The documentation is available on [HexDocs](https://hexdocs.pm/gleam_zlists/).

## Installation

Add `gleam_zlists` to your `rebar.config` dependencies:

```erlang
{deps, [
    {gleam_zlists, "0.0.3"}
]}.
```

## Examples

```rust
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
// [tuple("a", 0), tuple("b", 1), tuple("c", 2)]
```
