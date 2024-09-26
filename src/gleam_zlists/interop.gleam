pub type ZList(a)

@external(erlang, "zlists", "new")
pub fn new_1(x: List(t), y: fn() -> List(t)) -> ZList(t)

@external(erlang, "zlists", "new")
pub fn new_2(x: ZList(t), y: fn() -> ZList(t)) -> ZList(t)

@external(erlang, "zlists", "generate")
pub fn generate(x: ZList(t), y: fn(t) -> ZList(t1)) -> ZList(t1)

@external(erlang, "zlists", "recurrent")
pub fn recurrent_2(x: t, y: fn(t) -> t) -> ZList(t)

@external(erlang, "zlists", "recurrent")
pub fn recurrent_3(x: t, y: t1, z: fn(t, t1) -> #(t, t1)) -> ZList(t)

@external(erlang, "zlists", "foreach")
pub fn foreach(x: fn(t) -> any, y: ZList(t)) -> Nil

@external(erlang, "zlists", "foldl")
pub fn foldl(x: fn(t, acc) -> acc, y: acc, z: ZList(t)) -> acc

@external(erlang, "zlists", "map")
pub fn map(x: fn(a) -> b, y: ZList(a)) -> ZList(b)

@external(erlang, "zlists", "seq")
pub fn seq(x: Int, y: Int, z: Int) -> ZList(Int)

@external(erlang, "zlists", "dropwhile")
pub fn dropwhile(x: fn(t) -> Bool, y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "drop")
pub fn drop(x: Int, y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "takewhile")
pub fn takewhile(x: fn(t) -> Bool, y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "take")
pub fn take(x: Int, y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "filter")
pub fn filter(x: fn(t) -> Bool, y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "expand")
pub fn expand(x: ZList(t)) -> List(t)

@external(erlang, "zlists", "append")
pub fn append(x: ZList(ZList(t))) -> ZList(t)

@external(erlang, "zlists", "scroll")
pub fn scroll(x: Int, y: ZList(t)) -> #(List(t), ZList(t))

@external(erlang, "zlists", "merge")
pub fn merge(x: ZList(t), y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "splitwith")
pub fn splitwith(x: fn(t) -> Bool, y: ZList(t)) -> #(List(t), ZList(t))

@external(erlang, "zlists", "cartesian")
pub fn cartesian(x: ZList(t), y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "zip")
pub fn zip(x: ZList(a), y: ZList(b)) -> ZList(#(a, b))

@external(erlang, "zlists", "ziph")
pub fn ziph(x: ZList(a), y: ZList(b)) -> ZList(#(a, b))

@external(erlang, "zlists", "unique")
pub fn unique_1(x: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "unique")
pub fn unique_2(x: fn(t, t) -> Bool, y: ZList(t)) -> ZList(t)

@external(erlang, "zlists", "count")
pub fn count(x: ZList(t)) -> Int

@external(erlang, "zlists", "print")
pub fn print(x: ZList(t)) -> Nil
