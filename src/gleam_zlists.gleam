//// This module contains some useful functions for working with **lazy lists**.
////
//// For more information see [this website](https://github.com/mrdimosthenis/gleam_zlists).

import erl/interface as api

/// A type for representing lazy lists.
pub type ZList(t) =
  api.ZList(t)

/// Converts a `list` to `ZList`.
///
pub fn of_list(list: List(t)) -> ZList(t) {
  api.new_1(list, fn() { [] })
}

/// Creates a ZList that contains the first argument, followed by the second.
///
/// # Examples
///
///   > zlist.append(zlist.range(1, 3, 1), zlist.range(4, 6, 1))
///   > |> zlist.to_list
///   [1, 2, 3, 4, 5, 6]
///
pub fn append(left: ZList(t), right: ZList(t)) -> ZList(t) {
  api.new_2(left, fn() { right })
}

/// Creates a `ZList` of just one specified `value`.
///
/// # Examples
///
///   > 10
///   > |> zlist.singleton
///   > |> zlist.to_list
///   [10]
///
pub fn singleton(value: t) -> ZList(t) {
  of_list([value])
}

/// Creates an empty `ZList`.
///
/// # Examples
///
///   > zlist.empty()
///   > |> zlist.to_list
///   []
///
pub fn empty() -> ZList(t) {
  of_list([])
}

/// Determines if the `ZList` is empty.
///
/// # Examples
///
///   > []
///   > |> zlist.of_list
///   > |> zlist.is_empty
///   True
///
///   > [1, 2, 3]
///   > |> zlist.of_list
///   > |> zlist.is_empty
///   False
///
pub fn is_empty(zlist: ZList(t)) -> Bool {
  count(zlist) == 0
}

/// Return a new `ZList` which contains the `first_value` followed by the `zlist`.
///
/// # Examples
///
///   > zlist.range(1, 3, 1)
///   > |> zlist.cons(0)
///   > |> zlist.to_list
///   [0, 1, 2, 3]
///
pub fn cons(zlist: ZList(t), first_value) -> ZList(t) {
  first_value
  |> singleton
  |> append(zlist)
}

/// Gets the first element of the `zlist`, if there is one.
///
/// # Examples
///
///   > zlist.range(1, 3, 1)
///   > |> zlist.head
///   Ok(1)
///
///   > zlist.empty()
///   > |> zlist.head
///   Error(Nil)
///
pub fn head(zlist: ZList(t)) -> Result(t, Nil) {
  let ls =
    zlist
    |> take(1)
    |> to_list
  case ls {
    [] -> Error(Nil)
    [v] -> Ok(v)
  }
}

/// Gets the `zlist` minus the first value. If the `zlist` is empty, `Error(Nil)` is returned.
///
/// # Examples
///
///   > zlist.range(1, 3, 1)
///   > |> zlist.tail
///   > |> result.map(zlist.to_list)
///   Ok([2, 3])
///
///   > zlist.empty()
///   > |> zlist.tail
///   Error(Nil)
///
pub fn tail(zlist: ZList(t)) -> Result(ZList(t), Nil) {
  let ls =
    zlist
    |> take(1)
    |> to_list
  case ls {
    [] -> Error(Nil)
    [_] ->
      zlist
      |> drop(1)
      |> Ok
  }
}

/// Returns the tuple of the head value and the tail of the list. If the `zlist` is empty, `Error(Nil)` is returned.
///
/// # Examples
///
///   > zlist.range(1, 3, 1)
///   > |> zlist.uncons
///   > |> result.map(fn(res) {
///   >   let tuple(hd, tl) = res
///   >   tuple(hd, zlist.to_list(tl))
///   > })
///   Ok(tuple(1, [2, 3]))
///
pub fn uncons(zlist: ZList(t)) -> Result(tuple(t, ZList(t)), Nil) {
  case tuple(head(zlist), tail(zlist)) {
    tuple(Ok(hd), Ok(tl)) ->
      tuple(hd, tl)
      |> Ok
    _ -> Error(Nil)
  }
}

/// Converts a `zlist` to `List`.
///
/// # Examples
///
///   > zlist.range(0, 3, 1)
///   > |> zlist.to_list
///   [0, 1, 2, 3]
///
pub fn to_list(zlist: ZList(t)) -> List(t) {
  api.expand(zlist)
}

/// Returns a lazy range from `first` to `last` (included).
/// The difference between one term and the next equals to `step`.
/// The `step` should be **positive**.
///
/// # Examples
///
///   > zlist.range(0, 3, 1)
///   > |> zlist.to_list
///   [0, 1, 2, 3]
///
///   > zlist.range(-3, 5, 2)
///   > |> zlist.to_list
///   [-3, -1, 1, 3, 5]
///
pub fn range(first: Int, last: Int, step: Int) -> ZList(Int) {
  api.seq(first, last, step)
}

/// Lazily takes the first `n` elements from the `zlist`.
/// The `n` should **not** be **negative**.
///
/// # Examples
///
///   > zlist.range(1, 100, 1)
///   > |> zlist.take(5)
///   > |> zlist.to_list
///   [1, 2, 3, 4, 5]
///
pub fn take(zlist: ZList(t), n: Int) -> ZList(t) {
  api.take(n, zlist)
}

/// Maps the given `fun` over `zlist` and flattens the result.
/// This function returns a new `ZList` built by appending the result of invoking `fun` on each element of `zlist` together.
///
/// # Examples
///
///   > [1, 2, 3]
///   > |> zlist.of_list
///   > |> zlist.flat_map(fn(x) { zlist.of_list([x, 2 * x]) })
///   > |> zlist.to_list
///   [1, 2, 2, 4, 3, 6]
///
pub fn flat_map(zlist: ZList(t), fun: fn(t) -> ZList(t1)) -> ZList(t1) {
  api.generate(zlist, fun)
}

/// Emits a `ZList` of values, starting with `start_value`.
/// Successive values are generated by calling `next_fun` on the previous value.
///
/// # Examples
///
///   > zlist.iterate(0, fn(x) { x + 1 })
///   > |> zlist.take(5)
///   > |> zlist.to_list
///   [0, 1, 2, 3, 4]
///
pub fn iterate(start_value: t, next_fun: fn(t) -> t) -> ZList(t) {
  api.recurrent_2(start_value, next_fun)
}

/// Executes the given function for each element.
/// Useful for adding side effects (like printing) to a `ZList`.
///
pub fn each(zlist: ZList(t), fun: fn(t) -> any) -> Nil {
  api.foreach(fun, zlist)
}

/// Invokes `fun` for each element in the `zlist` with the accumulator.
/// The initial value of the accumulator is `acc`.
/// The function is invoked for each element in the `zlist` with the accumulator.
/// The result returned by the function is used as the accumulator for the next iteration.
/// The function returns the last accumulator.
///
/// # Examples
///
///   > [1, 2, 3]
///   > |> zlist.of_list
///   > |> zlist.reduce(0, fn(x, acc) { x + acc })
///   6
///
pub fn reduce(zlist: ZList(t), acc: accum, fun: fn(t, accum) -> accum) -> accum {
  api.foldl(fun, acc, zlist)
}

/// Returns a `ZList` where each element is the result of invoking `fun` on each corresponding element of `zlist`.
///
/// # Examples
///
///   > [1, 2, 3]
///   > |> zlist.of_list
///   > |> zlist.map(fn(x) { 2 * x })
///   > |> zlist.to_list
///   [2, 4, 6]
///
pub fn map(zlist: ZList(a), fun: fn(a) -> b) -> ZList(b) {
  api.map(fun, zlist)
}

/// Drops elements at the beginning of the `zlist` while `fun` returns a `True`.
///
/// # Examples
///
///   > [1, 2, 3, 2, 1]
///   > |> zlist.of_list
///   > |> zlist.drop_while(fn(x) { x < 3 })
///   > |> zlist.to_list
///   [3, 2, 1]
///
pub fn drop_while(zlist: ZList(t), fun: fn(t) -> Bool) -> ZList(t) {
  api.dropwhile(fun, zlist)
}

/// Lazily drops the next `n` elements from the `zlist`.
/// `n` should **not** be **negative** or **greater** than the **length** of the `zlist`.
///
/// # Examples
///
///   > [1, 2, 3]
///   > |> zlist.of_list
///   > |> zlist.drop(2)
///   > |> zlist.to_list
///   [3]
///
pub fn drop(zlist: ZList(t), n: Int) -> ZList(t) {
  api.drop(n, zlist)
}

/// Lazily takes elements of the `zlist` while the given function returns `True`.
///
/// # Examples
///
///   > zlist.range(1, 100, 1)
///   > |> zlist.take_while(fn(x) { x <= 5 })
///   > |> zlist.to_list
///   [1, 2, 3, 4, 5]
///
pub fn take_while(zlist: ZList(t), fun: fn(t) -> Bool) -> ZList(t) {
  api.takewhile(fun, zlist)
}

/// Filters the `zlist`, i.e. returns only those elements for which fun returns `True`.
///
/// # Examples
///
///   > [1, 2, 3]
///   > |> zlist.of_list
///   > |> zlist.filter(fn(x) { int.is_even(x) })
///   > |> zlist.to_list
///   [2]
///
pub fn filter(zlist: ZList(t), fun: fn(t) -> Bool) -> ZList(t) {
  api.filter(fun, zlist)
}

/// Given an `ZList` of `ZList`, concatenates them into a single `ZList`.
///
/// # Examples
///
///   > [zlist.range(1, 3, 1), zlist.range(4, 6, 1), zlist.range(7, 9, 1)]
///   > |> zlist.of_list
///   > |> zlist.concat
///   > |> zlist.to_list
///   [1, 2, 3, 4, 5, 6, 7, 8, 9]
///
pub fn concat(zlists: ZList(ZList(t))) -> ZList(t) {
  api.append(zlists)
}

/// Splits the `zlist` into a `List` and a `ZList`, leaving `n` elements in the first one.
///
/// # Examples
///
///   > let tuple(ls_a, zls_b) =
///   >   [1, 2, 3]
///   >   |> zlist.of_list
///   >   |> zlist.split(2)
///   > let ls_b = zlist.to_list(zls_b)
///   > tuple(ls_a, ls_b)
///   tuple([1, 2], [3])
///
pub fn split(zlist: ZList(t), n: Int) -> tuple(List(t), ZList(t)) {
  api.scroll(n, zlist)
}

/// Splits `zlist` into a `List` and a `ZList` at the position of the element for which `fun` returns `False` for the first time.
///
/// # Examples
///
///   > let tuple(ls_a, zls_b) =
///   >   [1, 2, 3, 4]
///   >   |> zlist.of_list
///   >   |> zlist.split_while(fn(x) { x < 3 })
///   > let ls_b = zlist.to_list(zls_b)
///   > tuple(ls_a, ls_b)
///   tuple([1, 2], [3, 4])
///
pub fn split_while(
  zlist: ZList(t),
  fun: fn(t) -> Bool,
) -> tuple(List(t), ZList(t)) {
  api.splitwith(fun, zlist)
}

/// Zips `left` and `right` together, lazily.
/// The zipping finishes as soon as any `ZList` completes.
///
/// # Examples
///
///   > let left = zlist.of_list([1, 2, 3])
///   > let right = zlist.of_list(["foo", "bar", "baz"])
///   > zlist.zip(left, right)
///   > |> zlist.to_list
///   [tuple(1, "foo"), tuple(2, "bar"), tuple(3, "baz")]
///
pub fn zip(left: ZList(a), right: ZList(b)) -> ZList(tuple(a, b)) {
  api.ziph(left, right)
}

/// Creates a `ZList` that only emits elements if they are different from the last emitted element.
/// This function only ever needs to store the last emitted element.
///
/// # Examples
///
///   > [1, 2, 3, 3, 2, 1]
///   > |> zlist.of_list
///   > |> zlist.dedup
///   > |> zlist.to_list
///   [1, 2, 3, 2, 1]
///
pub fn dedup(zlist: ZList(t)) -> ZList(t) {
  api.unique_1(zlist)
}

/// Returns the size of the `zlist`.
///
/// # Examples
///
///   > [1, 2, 3]
///   > |> zlist.of_list
///   > |> zlist.count
///   3
///
pub fn count(zlist: ZList(t)) -> Int {
  api.count(zlist)
}
