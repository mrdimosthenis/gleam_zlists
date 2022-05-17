pub external type ZList(a)

pub external fn new_1(List(t), fn() -> List(t)) -> ZList(t) =
  "zlists" "new"

pub external fn new_2(ZList(t), fn() -> ZList(t)) -> ZList(t) =
  "zlists" "new"

pub external fn generate(ZList(t), fn(t) -> ZList(t1)) -> ZList(t1) =
  "zlists" "generate"

pub external fn recurrent_2(t, fn(t) -> t) -> ZList(t) =
  "zlists" "recurrent"

pub external fn recurrent_3(t, t1, fn(t, t1) -> #(t, t1)) -> ZList(t) =
  "zlists" "recurrent"

pub external fn foreach(fn(t) -> any, ZList(t)) -> Nil =
  "zlists" "foreach"

pub external fn foldl(fn(t, acc) -> acc, acc, ZList(t)) -> acc =
  "zlists" "foldl"

pub external fn map(fn(a) -> b, ZList(a)) -> ZList(b) =
  "zlists" "map"

pub external fn seq(Int, Int, Int) -> ZList(Int) =
  "zlists" "seq"

pub external fn dropwhile(fn(t) -> Bool, ZList(t)) -> ZList(t) =
  "zlists" "dropwhile"

pub external fn drop(Int, ZList(t)) -> ZList(t) =
  "zlists" "drop"

pub external fn takewhile(fn(t) -> Bool, ZList(t)) -> ZList(t) =
  "zlists" "takewhile"

pub external fn take(Int, ZList(t)) -> ZList(t) =
  "zlists" "take"

pub external fn filter(fn(t) -> Bool, ZList(t)) -> ZList(t) =
  "zlists" "filter"

pub external fn expand(ZList(t)) -> List(t) =
  "zlists" "expand"

pub external fn append(ZList(ZList(t))) -> ZList(t) =
  "zlists" "append"

pub external fn scroll(Int, ZList(t)) -> #(List(t), ZList(t)) =
  "zlists" "scroll"

pub external fn merge(ZList(t), ZList(t)) -> ZList(t) =
  "zlists" "merge"

pub external fn splitwith(fn(t) -> Bool, ZList(t)) -> #(List(t), ZList(t)) =
  "zlists" "splitwith"

pub external fn cartesian(ZList(t), ZList(t)) -> ZList(t) =
  "zlists" "cartesian"

pub external fn zip(ZList(a), ZList(b)) -> ZList(#(a, b)) =
  "zlists" "zip"

pub external fn ziph(ZList(a), ZList(b)) -> ZList(#(a, b)) =
  "zlists" "ziph"

pub external fn unique_1(ZList(t)) -> ZList(t) =
  "zlists" "unique"

pub external fn unique_2(fn(t, t) -> Bool, ZList(t)) -> ZList(t) =
  "zlists" "unique"

pub external fn count(ZList(t)) -> Int =
  "zlists" "count"

pub external fn print(ZList(t)) -> Nil =
  "zlists" "print"
