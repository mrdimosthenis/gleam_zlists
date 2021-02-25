# gleam_zlists

A Gleam project

## Quick start

```sh
# Run the eunit tests
rebar3 eunit

# Run the Erlang REPL
rebar3 shell
```

## Installation

If [available in Hex](https://rebar3.org/docs/configuration/dependencies/#declaring-dependencies)
this package can be installed by adding `gleam_zlists` to your `rebar.config` dependencies:

```erlang
{deps, [
    gleam_zlists
]}.
```

## Examples

```
> import gleam_zlists.{ZList} as zlist

> [1, 2, 3]
> |> zlist.of_list
> |> zlist.map(fn(x) { 2 * x })
> |> zlist.to_list
[2, 4, 6]

> [1, 2, 3]
> |> zlist.of_list
> |> zlist.filter(fn(x) { int.is_even(x) })
> |> zlist.to_list
[2]

> [1, 2, 3]
> |> zlist.of_list
> |> zlist.reduce(0, fn(x, acc) { x + acc })
6

> zlist.iterate(0, fn(x) { x + 1 })
> |> zlist.take(5)
> |> zlist.to_list
[0, 1, 2, 3, 4]
```

## Function Signatures

```
concat(zlists: ZList(ZList(a))) -> ZList(a)
```

```
count(zlist: ZList(a)) -> Int
```

```
dedup(zlist: ZList(a)) -> ZList(a)
```

```
drop(zlist: ZList(a), n: Int) -> ZList(a)
```

```
drop_while(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```
each(zlist: ZList(a), fun: fn(a) -> b) -> Nil
```

```
filter(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```
flat_map(zlist: ZList(a), fun: fn(a) -> ZList(b)) -> ZList(b)
```

```
iterate(start_value: a, next_fun: fn(a) -> a) -> ZList(a)
```

```
map(zlist: ZList(a), fun: fn(a) -> b) -> ZList(b)
```

```
of_list(list: List(a)) -> ZList(a)
```

```
range(first: Int, last: Int, step: Int) -> ZList(Int)
```

```
reduce(zlist: ZList(a), acc: b, fun: fn(a, b) -> b) -> b
```

```
split(zlist: ZList(a), n: Int) -> tuple(List(a), ZList(a))
```

```
split_while(zlist: ZList(a), fun: fn(a) -> Bool) -> tuple(List(a), ZList(a))
```

```
take(zlist: ZList(a), n: Int) -> ZList(a)
```

```
take_while(zlist: ZList(a), fun: fn(a) -> Bool) -> ZList(a)
```

```
to_list(zlist: ZList(a)) -> List(a)
```

```
zip(left: ZList(a), right: ZList(b)) -> ZList(tuple(a, b))
```
