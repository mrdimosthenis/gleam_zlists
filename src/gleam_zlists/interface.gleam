import gleam_zlists/interop

pub type ZList(t) =
  interop.ZList(t)

pub fn new_1(ls: List(t), f: fn() -> List(t)) -> ZList(t) {
  interop.new_1(ls, f)
}

pub fn new_2(ls: ZList(t), f: fn() -> ZList(t)) -> ZList(t) {
  interop.new_2(ls, f)
}

pub fn generate(zl: ZList(t), f: fn(t) -> ZList(t1)) -> ZList(t1) {
  interop.generate(zl, f)
}

pub fn recurrent_2(elem: t, f: fn(t) -> t) -> ZList(t) {
  interop.recurrent_2(elem, f)
}

pub fn recurrent_3(
  elem: t,
  elem_1: t1,
  f: fn(t, t1) -> tuple(t, t1),
) -> ZList(t) {
  interop.recurrent_3(elem, elem_1, f)
}

pub fn foreach(f: fn(t) -> any, zl: ZList(t)) -> Nil {
  interop.foreach(f, zl)
}

pub fn foldl(f: fn(t, acc) -> acc, accum: acc, zl: ZList(t)) -> acc {
  interop.foldl(f, accum, zl)
}

pub fn map(f: fn(a) -> b, zl: ZList(a)) -> ZList(b) {
  interop.map(f, zl)
}

pub fn seq(from: Int, to: Int, incr: Int) -> ZList(Int) {
  interop.seq(from, to, incr)
}

pub fn dropwhile(pred: fn(t) -> Bool, zl: ZList(t)) -> ZList(t) {
  interop.dropwhile(pred, zl)
}

pub fn drop(n: Int, zl: ZList(t)) -> ZList(t) {
  interop.drop(n, zl)
}

pub fn takewhile(pred: fn(t) -> Bool, zl: ZList(t)) -> ZList(t) {
  interop.takewhile(pred, zl)
}

pub fn take(n: Int, zl: ZList(t)) -> ZList(t) {
  interop.take(n, zl)
}

pub fn filter(pred: fn(t) -> Bool, zl: ZList(t)) -> ZList(t) {
  interop.filter(pred, zl)
}

pub fn expand(zl: ZList(t)) -> List(t) {
  interop.expand(zl)
}

pub fn append(zlsts: ZList(ZList(t))) -> ZList(t) {
  interop.append(zlsts)
}

pub fn scroll(n: Int, zl: ZList(t)) -> tuple(List(t), ZList(t)) {
  interop.scroll(n, zl)
}

pub fn merge(zl_1: ZList(t), zl_2: ZList(t)) -> ZList(t) {
  interop.merge(zl_1, zl_2)
}

pub fn splitwith(pred: fn(t) -> Bool, zl: ZList(t)) -> tuple(List(t), ZList(t)) {
  interop.splitwith(pred, zl)
}

pub fn cartesian(zl_1: ZList(t), zl_2: ZList(t)) -> ZList(t) {
  interop.cartesian(zl_1, zl_2)
}

pub fn zip(zl_1: ZList(a), zl_2: ZList(b)) -> ZList(tuple(a, b)) {
  interop.zip(zl_1, zl_2)
}

pub fn ziph(zl_1: ZList(a), zl_2: ZList(b)) -> ZList(tuple(a, b)) {
  interop.ziph(zl_1, zl_2)
}

pub fn unique_1(zl: ZList(t)) -> ZList(t) {
  interop.unique_1(zl)
}

pub fn unique_2(pred: fn(t, t) -> Bool, zl: ZList(t)) -> ZList(t) {
  interop.unique_2(pred, zl)
}

pub fn count(zl: ZList(t)) -> Int {
  interop.count(zl)
}

pub fn print(zl: ZList(t)) -> Nil {
  interop.print(zl)
}
