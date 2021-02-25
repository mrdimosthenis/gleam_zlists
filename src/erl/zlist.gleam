pub external type ZList(a)

pub external fn new(List(a), fn() -> List(t)) -> ZList(t) =
  "erlang_zlists" "new"

pub external fn generate(ZList(t), fn(t) -> ZList(t1)) -> ZList(t1) =
  "erlang_zlists" "generate"

pub external fn recurrent_2(t, fn(t) -> t) -> ZList(t) =
  "erlang_zlists" "recurrent"

pub external fn recurrent_3(t, t1, fn(t, t1) -> tuple(t, t1)) -> ZList(t) =
  "erlang_zlists" "recurrent"

pub external fn foreach(fn(t) -> any, ZList(t)) -> Nil =
  "erlang_zlists" "foreach"

pub external fn foldl(fn(t, acc) -> acc, acc, ZList(t)) -> acc =
  "erlang_zlists" "foldl"

pub external fn map(fn(a) -> b, ZList(a)) -> ZList(b) =
  "erlang_zlists" "map"

pub external fn seq(Int, Int, Int) -> ZList(Int) =
  "erlang_zlists" "seq"

pub external fn dropwhile(fn(t) -> Bool, ZList(t)) -> ZList(t) =
  "erlang_zlists" "dropwhile"

pub external fn drop(Int, ZList(t)) -> ZList(t) =
  "erlang_zlists" "drop"

pub external fn takewhile(fn(t) -> Bool, ZList(t)) -> ZList(t) =
  "erlang_zlists" "takewhile"

pub external fn take(Int, ZList(t)) -> ZList(t) =
  "erlang_zlists" "take"

pub external fn filter(fn(t) -> Bool, ZList(t)) -> ZList(t) =
  "erlang_zlists" "filter"

pub external fn expand(ZList(t)) -> List(t) =
  "erlang_zlists" "expand"

pub external fn append(ZList(ZList(t))) -> ZList(t) =
  "erlang_zlists" "append"

pub external fn scroll(Int, ZList(t)) -> tuple(List(t), ZList(t)) =
  "erlang_zlists" "scroll"

pub external fn merge(ZList(t), ZList(t)) -> ZList(t) =
  "erlang_zlists" "merge"

pub external fn splitwith(fn(t) -> Bool, ZList(t)) -> tuple(List(t), ZList(t)) =
  "erlang_zlists" "splitwith"

pub external fn cartesian(ZList(t), ZList(t)) -> ZList(t) =
  "erlang_zlists" "cartesian"

pub external fn zip(ZList(a), ZList(b)) -> ZList(tuple(a, b)) =
  "erlang_zlists" "zip"

pub external fn ziph(ZList(a), ZList(b)) -> ZList(tuple(a, b)) =
  "erlang_zlists" "ziph"

pub external fn unique_1(ZList(t)) -> ZList(t) =
  "erlang_zlists" "unique"

pub external fn unique_2(fn(t, t) -> Bool, ZList(t)) -> ZList(t) =
  "erlang_zlists" "unique"

pub external fn count(ZList(t)) -> Int =
  "erlang_zlists" "count"

pub external fn print(ZList(t)) -> Nil =
  "erlang_zlists" "print"
