# gleam_zlists

A library for working with **lazy lists** in **Gleam**.

_Honestly, is just a wrapper for_ [vjache/erlang-zlists](https://github.com/vjache/erlang-zlists) :pleading_face:

## Installation

Add `gleam_zlists` to your `rebar.config` dependencies:

```erlang
{deps, [
    {gleam_zlists, {git, "https://github.com/mrdimosthenis/gleam_zlists", {tag, "0.1"}}
]}.
```

## Examples

```rust
import gleam_zlists.{ZList} as zlist

[1, 2, 3]
|> zlist.of_list
|> zlist.map(fn(x) { 2 * x })
|> zlist.to_list
// [2, 4, 6]

[1, 2, 3]
|> zlist.of_list
|> zlist.filter(fn(x) { int.is_even(x) })
|> zlist.to_list
// [2]

[1, 2, 3]
|> zlist.of_list
|> zlist.reduce(0, fn(x, acc) { x + acc })
// 6

zlist.iterate(0, fn(x) { x + 1 })
|> zlist.take(5)
|> zlist.to_list
// [0, 1, 2, 3, 4]
```

## Function Signatures

```rust
concat(zlists: ZList(ZList(a))) -> ZList(a)
```

```rust
count(zlist: ZList(a)) -> Int
```

```rust
dedup(zlist: ZList(a)) -> ZList(a)
```

```rust
drop(zlist: ZList(a), n: Int) -> ZList(a)
```

```rust
drop_while(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```rust
each(zlist: ZList(a), fun: fn(a) -> b) -> Nil
```

```rust
filter(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```rust
flat_map(zlist: ZList(a), fun: fn(a) -> ZList(b)) -> ZList(b)
```

```rust
iterate(start_value: a, next_fun: fn(a) -> a) -> ZList(a)
```

```rust
map(zlist: ZList(a), fun: fn(a) -> b) -> ZList(b)
```

```rust
of_list(list: List(a)) -> ZList(a)
```

```rust
range(first: Int, last: Int, step: Int) -> ZList(Int)
```

```rust
reduce(zlist: ZList(a), acc: b, fun: fn(a, b) -> b) -> b
```

```rust
split(zlist: ZList(a), n: Int) -> tuple(List(a), ZList(a))
```

```rust
split_while(zlist: ZList(a), fun: fn(a) -> Bool) -> tuple(List(a), ZList(a))
```

```rust
take(zlist: ZList(a), n: Int) -> ZList(a)
```

```rust
take_while(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```rust
to_list(zlist: ZList(a)) -> List(a)
```

```rust
zip(left: ZList(a), right: ZList(b)) -> ZList(tuple(a, b))
```
