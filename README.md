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
pub fn concat(zlists: ZList(ZList(a))) -> ZList(a)
```

```rust
count(zlist: ZList(a)) -> Int
```

```rust
pub fn dedup(zlist: ZList(a)) -> ZList(a)
```

```rust
pub fn drop(zlist: ZList(a), n: Int) -> ZList(a)
```

```rust
pub fn drop_while(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```rust
pub fn each(zlist: ZList(a), fun: fn(a) -> b) -> Nil
```

```rust
pub fn filter(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```rust
pub fn flat_map(zlist: ZList(a), fun: fn(a) -> ZList(b)) -> ZList(b)
```

```rust
pub fn iterate(start_value: a, next_fun: fn(a) -> a) -> ZList(a)
```

```rust
pub fn map(zlist: ZList(a), fun: fn(a) -> b) -> ZList(b)
```

```rust
pub fn of_list(list: List(a)) -> ZList(a)
```

```rust
pub fn range(first: Int, last: Int, step: Int) -> ZList(Int)
```

```rust
pub fn reduce(zlist: ZList(a), acc: b, fun: fn(a, b) -> b) -> b
```

```rust
pub fn split(zlist: ZList(a), n: Int) -> tuple(List(a), ZList(a))
```

```rust
pub fn split_while(zlist: ZList(a), fun: fn(a) -> Bool) -> tuple(List(a), ZList(a))
```

```rust
pub fn take(zlist: ZList(a), n: Int) -> ZList(a)
```

```rust
pub fn take_while(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```rust
pub fn to_list(zlist: ZList(a)) -> List(a)
```

```rust
pub fn zip(left: ZList(a), right: ZList(b)) -> ZList(tuple(a, b))
```
