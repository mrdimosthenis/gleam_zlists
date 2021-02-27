//// This module contains some useful functions for working with **lazy lists**.
////
//// For more information see [this website](https://github.com/mrdimosthenis/gleam_zlists).

import gleam/bool
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
///  ## Examples
///
/// ```
/// append(range(1, 3, 1), range(4, 6, 1))
/// |> to_list
/// [1, 2, 3, 4, 5, 6]
/// ```
///
pub fn append(left: ZList(t), right: ZList(t)) -> ZList(t) {
  api.new_2(left, fn() { right })
}

/// Converts a `zlist` to `List`.
///
///  ## Examples
///
/// ```
/// range(0, 3, 1)
/// |> to_list
/// [0, 1, 2, 3]
/// ```
///
pub fn to_list(zlist: ZList(t)) -> List(t) {
  api.expand(zlist)
}

/// Returns a lazy range from `first` to `last` (included).
/// The difference between one term and the next equals to `step`.
/// The `step` should be **positive**.
///
///  ## Examples
///
/// ```
/// range(0, 3, 1)
/// |> to_list
/// [0, 1, 2, 3]
/// ```
///
/// ```
/// range(-3, 5, 2)
/// |> to_list
/// [-3, -1, 1, 3, 5]
/// ```
///
pub fn range(first: Int, last: Int, step: Int) -> ZList(Int) {
  api.seq(first, last, step)
}

/// Lazily takes the first `n` elements from the `zlist`.
/// The `n` should **not** be **negative**.
///
///  ## Examples
///
/// ```
/// range(1, 100, 1)
/// |> take(5)
/// |> to_list
/// [1, 2, 3, 4, 5]
/// ```
///
pub fn take(zlist: ZList(t), n: Int) -> ZList(t) {
  api.take(n, zlist)
}

/// Maps the given `fun` over `zlist` and flattens the result.
/// This function returns a new `ZList` built by appending the result of invoking `fun` on each element of `zlist` together.
///
///  ## Examples
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> flat_map(fn(x) { of_list([x, 2 * x]) })
/// |> to_list
/// [1, 2, 2, 4, 3, 6]
/// ```
///
pub fn flat_map(zlist: ZList(t), fun: fn(t) -> ZList(t1)) -> ZList(t1) {
  api.generate(zlist, fun)
}

/// Emits a `ZList` of values, starting with `start_value`.
/// Successive values are generated by calling `next_fun` on the previous value.
///
///  ## Examples
///
/// ```
/// iterate(0, fn(x) { x + 1 })
/// |> take(5)
/// |> to_list
/// [0, 1, 2, 3, 4]
/// ```
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
///  ## Examples
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> reduce(0, fn(x, acc) { x + acc })
/// 6
/// ```
///
pub fn reduce(zlist: ZList(t), acc: accum, fun: fn(t, accum) -> accum) -> accum {
  api.foldl(fun, acc, zlist)
}

/// Returns a `ZList` where each element is the result of invoking `fun` on each corresponding element of `zlist`.
///
///  ## Examples
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> map(fn(x) { 2 * x })
/// |> to_list
/// [2, 4, 6]
/// ```
///
pub fn map(zlist: ZList(a), fun: fn(a) -> b) -> ZList(b) {
  api.map(fun, zlist)
}

/// Drops elements at the beginning of the `zlist` while `fun` returns a `True`.
///
///  ## Examples
///
/// ```
/// [1, 2, 3, 2, 1]
/// |> of_list
/// |> drop_while(fn(x) { x < 3 })
/// |> to_list
/// [3, 2, 1]
/// ```
///
pub fn drop_while(zlist: ZList(t), fun: fn(t) -> Bool) -> ZList(t) {
  api.dropwhile(fun, zlist)
}

/// Lazily drops the next `n` elements from the `zlist`.
/// `n` should **not** be **negative**.
///
///  ## Examples
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> drop(2)
/// |> to_list
/// [3]
/// ```
///
pub fn drop(zlist: ZList(t), n: Int) -> ZList(t) {
  let tuple(_, zls) = split(zlist, n)
  zls
}

/// Lazily takes elements of the `zlist` while the given function returns `True`.
///
///  ## Examples
///
/// ```
/// range(1, 100, 1)
/// |> take_while(fn(x) { x <= 5 })
/// |> to_list
/// [1, 2, 3, 4, 5]
/// ```
///
pub fn take_while(zlist: ZList(t), fun: fn(t) -> Bool) -> ZList(t) {
  api.takewhile(fun, zlist)
}

/// Filters the `zlist`, i.e. returns only those elements for which fun returns `True`.
///
///  ## Examples
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> filter(fn(x) { int.is_even(x) })
/// |> to_list
/// [2]
/// ```
///
pub fn filter(zlist: ZList(t), fun: fn(t) -> Bool) -> ZList(t) {
  api.filter(fun, zlist)
}

/// Given an `ZList` of `ZList`, concatenates them into a single `ZList`.
///
///  ## Examples
///
/// ```
/// [range(1, 3, 1), range(4, 6, 1), range(7, 9, 1)]
/// |> of_list
/// |> concat
/// |> to_list
/// [1, 2, 3, 4, 5, 6, 7, 8, 9]
/// ```
///
pub fn concat(zlists: ZList(ZList(t))) -> ZList(t) {
  api.append(zlists)
}

/// Splits the `zlist` into a `List` and a `ZList`, leaving `n` elements in the first one.
///
///  ## Examples
///
/// ```
/// let tuple(ls_a, zls_b) =
///   [1, 2, 3]
///   |> of_list
///   |> split(2)
/// let ls_b = to_list(zls_b)
/// tuple(ls_a, ls_b)
/// tuple([1, 2], [3])
/// ```
///
pub fn split(zlist: ZList(t), n: Int) -> tuple(List(t), ZList(t)) {
  api.scroll(n, zlist)
}

/// Splits `zlist` into a `List` and a `ZList` at the position of the element for which `fun` returns `False` for the first time.
///
///  ## Examples
///
/// ```
/// let tuple(ls_a, zls_b) =
///   [1, 2, 3, 4]
///   |> of_list
///   |> split_while(fn(x) { x < 3 })
/// let ls_b = to_list(zls_b)
/// tuple(ls_a, ls_b)
/// tuple([1, 2], [3, 4])
/// ```
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
///  ## Examples
///
/// ```
/// let left = of_list([1, 2, 3])
/// let right = of_list(["foo", "bar", "baz"])
/// zip(left, right)
/// |> to_list
/// [tuple(1, "foo"), tuple(2, "bar"), tuple(3, "baz")]
/// ```
///
pub fn zip(left: ZList(a), right: ZList(b)) -> ZList(tuple(a, b)) {
  api.ziph(left, right)
}

/// Creates a `ZList` that only emits elements if they are different from the last emitted element.
/// This function only ever needs to store the last emitted element.
///
///  ## Examples
///
/// ```
///  [1, 2, 3, 3, 2, 1]
///  |> of_list
///  |> dedup
///  |> to_list
///  [1, 2, 3, 2, 1]
/// ```
///
pub fn dedup(zlist: ZList(t)) -> ZList(t) {
  api.unique_1(zlist)
}

/// Returns the size of the `zlist`.
///
///  ## Examples
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> count
/// 3
/// ```
///
pub fn count(zlist: ZList(t)) -> Int {
  api.count(zlist)
}

/// Creates a `ZList` of just one specified `value`.
///
///  ## Examples
///
/// ```
/// 10
/// |> singleton
/// |> to_list
/// [10]
/// ```
///
pub fn singleton(value: t) -> ZList(t) {
  of_list([value])
}

/// Creates an empty `ZList`.
///
///  ## Examples
///
/// ```
/// new()
/// |> to_list
/// []
/// ```
///
pub fn new() -> ZList(t) {
  of_list([])
}

/// Determines if the `ZList` is empty.
///
///  ## Examples
///
/// ```
/// []
/// |> of_list
/// |> is_empty
/// True
/// ```
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> is_empty
/// False
/// ```
///
pub fn is_empty(zlist: ZList(t)) -> Bool {
  let head_length =
    zlist
    |> take(1)
    |> count
  head_length == 0
}

/// Return a new `ZList` which contains the `first_value` followed by the `zlist`.
///
///  ## Examples
///
/// ```
/// range(1, 3, 1)
/// |> cons(0)
/// |> to_list
/// [0, 1, 2, 3]
/// ```
///
pub fn cons(zlist: ZList(t), first_value) -> ZList(t) {
  first_value
  |> singleton
  |> append(zlist)
}

/// Gets the first element of the `zlist`, if there is one.
///
///  ## Examples
///
/// ```
/// range(1, 3, 1)
/// |> head
/// Ok(1)
/// ```
///
/// ```
/// new()
/// |> head
/// Error(Nil)
/// ```
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

/// Gets the `zlist` minus the first element. If the `zlist` is empty, `Error(Nil)` is returned.
///
///  ## Examples
///
/// ```
/// range(1, 3, 1)
/// |> tail
/// |> result.map(to_list)
/// Ok([2, 3])
/// ```
///
/// ```
/// new()
/// |> tail
/// Error(Nil)
/// ```
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

/// Returns the tuple of the first element and the tail of the `zlist`. If the `zlist` is empty, `Error(Nil)` is returned.
///
///  ## Examples
///
/// ```
/// range(1, 3, 1)
/// |> uncons
/// |> result.map(fn(res) {
///   let tuple(hd, tl) = res
///   tuple(hd, to_list(tl))
/// })
/// Ok(tuple(1, [2, 3]))
/// ```
///
pub fn uncons(zlist: ZList(t)) -> Result(tuple(t, ZList(t)), Nil) {
  case tuple(head(zlist), tail(zlist)) {
    tuple(Ok(hd), Ok(tl)) ->
      tuple(hd, tl)
      |> Ok
    _ -> Error(Nil)
  }
}

/// Iterates over the `zlist` and invokes `fun` on each element.
/// When an invocation of `fun` returns `False`, iteration stops immediately and `False` is returned.
/// In all other cases `True` is returned.
///
///  ## Examples
///
/// ```
/// [2, 4, 6]
/// |> of_list
/// |> all(int.is_even)
/// True
/// ```
///
/// ```
/// [2, 3, 4]
/// |> of_list
/// |> all(int.is_even)
/// False
/// ```
///
/// ```
/// []
/// |> of_list
/// |> all(fn(x) { x > 0 })
/// True
/// ```
///
pub fn all(zlist: ZList(t), fun: fn(t) -> Bool) -> Bool {
  case uncons(zlist) {
    Error(Nil) -> True
    Ok(tuple(hd, tl)) -> {
      let head_bool = fun(hd)
      let tuple(_, diff_bool_zls) =
        split_while(tl, fn(x) { fun(x) == head_bool })
      case is_empty(diff_bool_zls) {
        True -> head_bool
        False -> bool.negate(head_bool)
      }
    }
  }
}

/// Iterates over the `zlist` and invokes `fun` on each element.
/// When an invocation of `fun` returns `True`, iteration stops immediately and `True` is returned.
/// In all other cases `False` is returned.
///
///  ## Examples
///
/// ```
/// [2, 4, 6]
/// |> of_list
/// |> any(int.is_odd)
/// False
/// ```
///
/// ```
/// [2, 3, 4]
/// |> of_list
/// |> any(int.is_odd)
/// True
/// ```
///
/// ```
/// []
/// |> of_list
/// |> any(fn(x) { x > 0 })
/// False
/// ```
///
pub fn any(zlist: ZList(t), fun: fn(t) -> Bool) -> Bool {
  let tuple(_, zls_b) =
    split_while(
      zlist,
      fn(x) {
        x
        |> fun
        |> bool.negate
      },
    )
  zls_b
  |> is_empty
  |> bool.negate
}

/// Finds the element at the given `index` (zero-based).
/// Returns `Ok(element)` if found, otherwise `Error(Nil)`.
///
///  ## Examples
///
/// ```
/// [2, 4, 6]
/// |> of_list
/// |> fetch(1)
/// Ok(4)
/// ```
///
/// ```
/// [2, 4, 6]
/// |> of_list
/// |> fetch(4)
/// Error(Nil)
/// ```
///
pub fn fetch(zlist: ZList(t), index: Int) -> Result(t, Nil) {
  zlist
  |> drop(index)
  |> head
}

/// Returns `Ok(element)` for the first element that `fun` returns `True`.
/// If no such element is found, returns `Error(Nil)`.
///
///  ## Examples
///
/// ```
/// [2, 3, 4]
/// |> of_list
/// |> find(int.is_odd)
/// Ok(3)
/// ```
///
/// ```
/// [2, 4, 6]
/// |> of_list
/// |> find(int.is_odd)
/// Error(Nil)
/// ```
///
pub fn find(zlist: ZList(t), fun: fn(t) -> Bool) -> Result(t, Nil) {
  zlist
  |> drop_while(fn(x) {
    x
    |> fun
    |> bool.negate
  })
  |> head
}

/// Checks if `element` exists within the `zlist`.
///
///  ## Examples
///
/// ```
/// [2, 3, 4]
/// |> of_list
/// |> has_member(3)
/// True
/// ```
///
/// ```
/// [2, 4, 6]
/// |> of_list
/// |> has_member(8)
/// False
/// ```
///
pub fn has_member(zlist: ZList(t), element: t) -> Bool {
  case find(zlist, fn(x) { x == element }) {
    Ok(_) -> True
    Error(Nil) -> False
  }
}

/// Returns a `ZList` of the elements in `zlist` in reverse order.
///
///  ## Examples
///
/// ```
/// [1, 2, 3]
/// |> of_list
/// |> reverse
/// |> to_list
/// [3, 2, 1]
/// ```
///
pub fn reverse(zlist: ZList(t)) -> ZList(t) {
  reduce(zlist, new(), fn(x, acc) { cons(acc, x) })
}

/// Returns a subset `ZList` of the given `zlist`, from `start_index` (zero-based) with `amount` number of elements if available.
/// Given an `zlist`, it drops elements right before element `start_index`, then takes `amount` of elements, returning as many elements as possible if there are not enough elements.
///
///  ## Examples
///
/// ```
/// range(1, 100, 1)
/// |> slice(5, 10)
/// |> to_list
/// [6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
/// ```
///
/// ```
/// range(1, 10, 1)
/// |> slice(5, 100)
/// |> to_list
/// [6, 7, 8, 9, 10]
/// ```
///
pub fn slice(zlist: ZList(t), start_index: Int, amount: Int) -> ZList(t) {
  zlist
  |> drop(start_index)
  |> take(amount)
}

/// Returns an infinite `ZList` that contains the non-negative integers (sorted).
///
///  ## Examples
///
/// ```
/// indices()
/// |> take(5)
/// |> to_list
/// [0, 1, 2, 3, 4]
/// ```
///
pub fn indices() -> ZList(Int) {
  iterate(0, fn(x) { x + 1 })
}

/// Returns the `zlist` with each element wrapped in a tuple alongside its index.
///
///  ## Examples
///
/// ```
/// ["a", "b", "c"]
/// |> of_list
/// |> with_index
/// |> to_list
/// [tuple("a", 0), tuple("b", 1), tuple("c", 2)]
/// ```
///
pub fn with_index(zlist: ZList(t)) -> ZList(tuple(t, Int)) {
  zip(zlist, indices())
}
