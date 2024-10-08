import gleam/int
import gleam/iterator.{Done, Next}
import gleam/result
import gleam/string
import gleam_zlists as zlist
import gleeunit/should

pub fn append_test() {
  zlist.append(zlist.range(1, 3, 1), zlist.range(4, 6, 1))
  |> zlist.to_list
  |> should.equal([1, 2, 3, 4, 5, 6])
}

pub fn range_test() {
  zlist.range(0, 3, 1)
  |> zlist.to_list
  |> should.equal([0, 1, 2, 3])

  zlist.range(-3, 5, 2)
  |> zlist.to_list
  |> should.equal([-3, -1, 1, 3, 5])
}

pub fn take_test() {
  zlist.range(1, 100, 1)
  |> zlist.take(5)
  |> zlist.to_list
  |> should.equal([1, 2, 3, 4, 5])

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.take(5)
  |> zlist.to_list
  |> should.equal([1, 2, 3])

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.take(0)
  |> zlist.to_list
  |> should.equal([])

  []
  |> zlist.of_list
  |> zlist.take(3)
  |> zlist.to_list
  |> should.equal([])
}

pub fn flat_map_test() {
  [1, 2, 3]
  |> zlist.of_list
  |> zlist.flat_map(fn(x) { zlist.of_list([x, 2 * x]) })
  |> zlist.to_list
  |> should.equal([1, 2, 2, 4, 3, 6])
}

pub fn iterate_test() {
  zlist.iterate(0, fn(x) { x + 1 })
  |> zlist.take(5)
  |> zlist.to_list
  |> should.equal([0, 1, 2, 3, 4])
}

pub fn reduce_test() {
  [1, 2, 3]
  |> zlist.of_list
  |> zlist.reduce(0, fn(x, acc) { x + acc })
  |> should.equal(6)

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.reduce("0", fn(x, acc) {
    x
    |> int.to_string
    |> string.append(acc)
  })
  |> should.equal("3210")
}

pub fn map_test() {
  [1, 2, 3]
  |> zlist.of_list
  |> zlist.map(fn(x) { 2 * x })
  |> zlist.to_list
  |> should.equal([2, 4, 6])
}

pub fn drop_while_test() {
  [1, 2, 3, 2, 1]
  |> zlist.of_list
  |> zlist.drop_while(fn(x) { x < 3 })
  |> zlist.to_list
  |> should.equal([3, 2, 1])

  [1, 2, 3, 2, 1]
  |> zlist.of_list
  |> zlist.drop_while(fn(_) { True })
  |> zlist.to_list
  |> should.equal([])

  [1, 2, 3, 2, 1]
  |> zlist.of_list
  |> zlist.drop_while(fn(_) { False })
  |> zlist.to_list
  |> should.equal([1, 2, 3, 2, 1])

  []
  |> zlist.of_list
  |> zlist.drop_while(fn(_) { True })
  |> zlist.to_list
  |> should.equal([])
}

pub fn drop_test() {
  [1, 2, 3]
  |> zlist.of_list
  |> zlist.drop(2)
  |> zlist.to_list
  |> should.equal([3])

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.drop(0)
  |> zlist.to_list
  |> should.equal([1, 2, 3])

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.drop(10)
  |> zlist.to_list
  |> should.equal([])

  []
  |> zlist.of_list
  |> zlist.drop(10)
  |> zlist.to_list
  |> should.equal([])
}

pub fn take_while_test() {
  zlist.range(1, 100, 1)
  |> zlist.take_while(fn(x) { x <= 5 })
  |> zlist.to_list
  |> should.equal([1, 2, 3, 4, 5])

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.take_while(fn(_) { True })
  |> zlist.to_list
  |> should.equal([1, 2, 3])

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.take_while(fn(_) { False })
  |> zlist.to_list
  |> should.equal([])
}

pub fn filter_test() {
  [1, 2, 3]
  |> zlist.of_list
  |> zlist.filter(int.is_even)
  |> zlist.to_list
  |> should.equal([2])
}

pub fn concat_test() {
  [zlist.range(1, 3, 1), zlist.range(4, 6, 1), zlist.range(7, 9, 1)]
  |> zlist.of_list
  |> zlist.concat
  |> zlist.to_list
  |> should.equal([1, 2, 3, 4, 5, 6, 7, 8, 9])
}

pub fn split_1_test() {
  let #(ls_a, zls_b) =
    [1, 2, 3]
    |> zlist.of_list
    |> zlist.split(2)
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([1, 2], [3]))
}

pub fn split_2_test() {
  let #(ls_a, zls_b) =
    [1, 2, 3]
    |> zlist.of_list
    |> zlist.split(10)
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([1, 2, 3], []))
}

pub fn split_3_test() {
  let #(ls_a, zls_b) =
    [1, 2, 3]
    |> zlist.of_list
    |> zlist.split(0)
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([], [1, 2, 3]))
}

pub fn split_4_test() {
  let #(ls_a, zls_b) =
    []
    |> zlist.of_list
    |> zlist.split(4)
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([], []))
}

pub fn split_while_1_test() {
  let #(ls_a, zls_b) =
    [1, 2, 3, 4]
    |> zlist.of_list
    |> zlist.split_while(fn(x) { x < 3 })
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([1, 2], [3, 4]))
}

pub fn split_while_2_test() {
  let #(ls_a, zls_b) =
    [1, 2, 3, 4]
    |> zlist.of_list
    |> zlist.split_while(fn(x) { x < 0 })
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([], [1, 2, 3, 4]))
}

pub fn split_while_3_test() {
  let #(ls_a, zls_b) =
    [1, 2, 3, 4]
    |> zlist.of_list
    |> zlist.split_while(fn(x) { x > 0 })
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([1, 2, 3, 4], []))
}

pub fn split_while_4_test() {
  let #(ls_a, zls_b) =
    []
    |> zlist.of_list
    |> zlist.split_while(fn(x) { x < 0 })
  let ls_b = zlist.to_list(zls_b)
  should.equal(#(ls_a, ls_b), #([], []))
}

pub fn zip_1_test() {
  let left = zlist.of_list([1, 2, 3])
  let right = zlist.of_list(["foo", "bar", "baz"])
  zlist.zip(left, right)
  |> zlist.to_list
  |> should.equal([#(1, "foo"), #(2, "bar"), #(3, "baz")])
}

pub fn zip_2_test() {
  let left = zlist.of_list([1, 2, 3, 4, 5])
  let right = zlist.of_list(["foo", "bar", "baz"])
  zlist.zip(left, right)
  |> zlist.to_list
  |> should.equal([#(1, "foo"), #(2, "bar"), #(3, "baz")])
}

pub fn zip_3_test() {
  let left = zlist.of_list([1, 2, 3])
  let right = zlist.of_list(["foo", "bar", "baz", "far"])
  zlist.zip(left, right)
  |> zlist.to_list
  |> should.equal([#(1, "foo"), #(2, "bar"), #(3, "baz")])
}

pub fn dedup_test() {
  [1, 2, 3, 3, 2, 1]
  |> zlist.of_list
  |> zlist.dedup
  |> zlist.to_list
  |> should.equal([1, 2, 3, 2, 1])

  []
  |> zlist.of_list
  |> zlist.dedup
  |> zlist.to_list
  |> should.equal([])
}

pub fn count_test() {
  [1, 2, 3]
  |> zlist.of_list
  |> zlist.count
  |> should.equal(3)

  []
  |> zlist.of_list
  |> zlist.count
  |> should.equal(0)
}

pub fn singleton_test() {
  10
  |> zlist.singleton
  |> zlist.to_list
  |> should.equal([10])
}

pub fn new_test() {
  zlist.new()
  |> zlist.to_list
  |> should.equal([])
}

pub fn is_empty_test() {
  []
  |> zlist.of_list
  |> zlist.is_empty
  |> should.equal(True)

  [1, 2, 3]
  |> zlist.of_list
  |> zlist.is_empty
  |> should.equal(False)

  [1]
  |> zlist.of_list
  |> zlist.is_empty
  |> should.equal(False)
}

pub fn cons_test() {
  zlist.range(1, 3, 1)
  |> zlist.cons(0)
  |> zlist.to_list
  |> should.equal([0, 1, 2, 3])

  []
  |> zlist.of_list
  |> zlist.cons(1)
  |> zlist.to_list
  |> should.equal([1])
}

pub fn head_test() {
  zlist.range(1, 3, 1)
  |> zlist.head
  |> should.equal(Ok(1))

  10
  |> zlist.singleton
  |> zlist.head
  |> should.equal(Ok(10))

  zlist.new()
  |> zlist.head
  |> should.equal(Error(Nil))
}

pub fn tail_test() {
  zlist.range(1, 3, 1)
  |> zlist.tail
  |> result.map(zlist.to_list)
  |> should.equal(Ok([2, 3]))

  10
  |> zlist.singleton
  |> zlist.tail
  |> result.map(zlist.to_list)
  |> should.equal(Ok([]))

  zlist.new()
  |> zlist.tail
  |> should.equal(Error(Nil))
}

pub fn uncons_test() {
  zlist.range(1, 3, 1)
  |> zlist.uncons
  |> result.map(fn(res) {
    let #(hd, tl) = res
    #(hd, zlist.to_list(tl))
  })
  |> should.equal(Ok(#(1, [2, 3])))

  10
  |> zlist.singleton
  |> zlist.uncons
  |> result.map(fn(res) {
    let #(hd, tl) = res
    #(hd, zlist.to_list(tl))
  })
  |> should.equal(Ok(#(10, [])))

  zlist.new()
  |> zlist.uncons
  |> should.equal(Error(Nil))
}

pub fn all_test() {
  [2, 4, 6]
  |> zlist.of_list
  |> zlist.all(int.is_even)
  |> should.equal(True)

  [2, 3, 4]
  |> zlist.of_list
  |> zlist.all(int.is_even)
  |> should.equal(False)

  []
  |> zlist.of_list
  |> zlist.all(fn(x) { x > 0 })
  |> should.equal(True)

  [1]
  |> zlist.of_list
  |> zlist.all(fn(x) { x > 0 })
  |> should.equal(True)

  [1]
  |> zlist.of_list
  |> zlist.all(fn(x) { x < 0 })
  |> should.equal(False)
}

pub fn any_test() {
  [2, 4, 6]
  |> zlist.of_list
  |> zlist.any(int.is_odd)
  |> should.equal(False)

  [2, 3, 4]
  |> zlist.of_list
  |> zlist.any(int.is_odd)
  |> should.equal(True)

  []
  |> zlist.of_list
  |> zlist.any(fn(x) { x > 0 })
  |> should.equal(False)

  [1]
  |> zlist.of_list
  |> zlist.any(fn(x) { x > 0 })
  |> should.equal(True)

  [1]
  |> zlist.of_list
  |> zlist.any(fn(x) { x < 0 })
  |> should.equal(False)
}

pub fn fetch_test() {
  [2, 4, 6]
  |> zlist.of_list
  |> zlist.fetch(0)
  |> should.equal(Ok(2))

  [2, 4, 6]
  |> zlist.of_list
  |> zlist.fetch(2)
  |> should.equal(Ok(6))

  [2, 4, 6]
  |> zlist.of_list
  |> zlist.fetch(3)
  |> should.equal(Error(Nil))

  []
  |> zlist.of_list
  |> zlist.fetch(0)
  |> should.equal(Error(Nil))
}

pub fn find_test() {
  [2, 3, 4]
  |> zlist.of_list
  |> zlist.find(int.is_odd)
  |> should.equal(Ok(3))

  [2, 4, 6]
  |> zlist.of_list
  |> zlist.find(int.is_odd)
  |> should.equal(Error(Nil))

  []
  |> zlist.of_list
  |> zlist.find(int.is_odd)
  |> should.equal(Error(Nil))
}

pub fn has_member_test() {
  [2, 3, 4]
  |> zlist.of_list
  |> zlist.has_member(3)
  |> should.equal(True)

  [2, 4, 6]
  |> zlist.of_list
  |> zlist.has_member(8)
  |> should.equal(False)

  [1]
  |> zlist.of_list
  |> zlist.has_member(1)
  |> should.equal(True)

  []
  |> zlist.of_list
  |> zlist.has_member(1)
  |> should.equal(False)
}

pub fn reverse_test() {
  [1, 2, 3]
  |> zlist.of_list
  |> zlist.reverse
  |> zlist.to_list
  |> should.equal([3, 2, 1])

  []
  |> zlist.of_list
  |> zlist.reverse
  |> zlist.to_list
  |> should.equal([])
}

pub fn slice_test() {
  zlist.range(1, 100, 1)
  |> zlist.slice(5, 10)
  |> zlist.to_list
  |> should.equal([6, 7, 8, 9, 10, 11, 12, 13, 14, 15])

  zlist.range(1, 10, 1)
  |> zlist.slice(5, 100)
  |> zlist.to_list
  |> should.equal([6, 7, 8, 9, 10])

  zlist.range(1, 10, 1)
  |> zlist.slice(5, 0)
  |> zlist.to_list
  |> should.equal([])

  zlist.range(1, 10, 1)
  |> zlist.slice(10, 0)
  |> zlist.to_list
  |> should.equal([])

  zlist.new()
  |> zlist.slice(10, 3)
  |> zlist.to_list
  |> should.equal([])
}

pub fn indices_test() {
  zlist.indices()
  |> zlist.take(3)
  |> zlist.to_list
  |> should.equal([0, 1, 2])

  zlist.indices()
  |> zlist.take(5)
  |> zlist.to_list
  |> should.equal([0, 1, 2, 3, 4])
}

pub fn with_index_test() {
  ["a", "b", "c"]
  |> zlist.of_list
  |> zlist.with_index
  |> zlist.to_list
  |> should.equal([#("a", 0), #("b", 1), #("c", 2)])

  []
  |> zlist.of_list
  |> zlist.with_index
  |> zlist.to_list
  |> should.equal([])
}

pub fn unzip_test() {
  let #(xs, ys) =
    [#("a", 1), #("b", 2), #("c", 3)]
    |> zlist.of_list
    |> zlist.unzip
  #(zlist.to_list(xs), zlist.to_list(ys))
  |> should.equal(#(["a", "b", "c"], [1, 2, 3]))

  let #(xs, ys) =
    [#("c", 3)]
    |> zlist.of_list
    |> zlist.unzip
  #(zlist.to_list(xs), zlist.to_list(ys))
  |> should.equal(#(["c"], [3]))

  zlist.new()
  |> zlist.unzip
  |> should.equal(#(zlist.new(), zlist.new()))
}

pub fn sum_test() {
  [0.0, 1.0, 2.0, 3.0, 4.0]
  |> zlist.of_list
  |> zlist.sum
  |> should.equal(10.0)

  4.0
  |> zlist.singleton
  |> zlist.sum
  |> should.equal(4.0)

  zlist.new()
  |> zlist.sum
  |> should.equal(0.0)
}

pub fn max_test() {
  [1.0, 3.0, 0.0, 2.0]
  |> zlist.of_list
  |> zlist.max
  |> should.equal(Ok(3.0))

  [10.0, -2.0, 3.0]
  |> zlist.of_list
  |> zlist.max
  |> should.equal(Ok(10.0))

  -2.0
  |> zlist.singleton
  |> zlist.max
  |> should.equal(Ok(-2.0))

  zlist.new()
  |> zlist.max
  |> should.equal(Error(Nil))
}

pub fn min_test() {
  [1.0, 3.0, 0.0, 2.0]
  |> zlist.of_list
  |> zlist.min
  |> should.equal(Ok(0.0))

  [10.0, -2.0, 3.0]
  |> zlist.of_list
  |> zlist.min
  |> should.equal(Ok(-2.0))

  -2.0
  |> zlist.singleton
  |> zlist.min
  |> should.equal(Ok(-2.0))

  zlist.new()
  |> zlist.min
  |> should.equal(Error(Nil))
}

pub fn to_iterator_test() {
  zlist.indices()
  |> zlist.to_iterator
  |> iterator.take(5)
  |> iterator.to_list
  |> should.equal([0, 1, 2, 3, 4])

  zlist.new()
  |> zlist.to_iterator
  |> iterator.to_list
  |> should.equal([])
}

pub fn of_iterator_test() {
  [1, 2]
  |> iterator.from_list
  |> iterator.cycle
  |> zlist.of_iterator
  |> zlist.take(5)
  |> zlist.to_list
  |> should.equal([1, 2, 1, 2, 1])

  []
  |> iterator.from_list
  |> zlist.of_iterator
  |> zlist.to_list
  |> should.equal([])

  [1]
  |> iterator.from_list
  |> zlist.of_iterator
  |> zlist.to_list
  |> should.equal([1])

  [1, 2]
  |> iterator.from_list
  |> zlist.of_iterator
  |> zlist.to_list
  |> should.equal([1, 2])

  [1, 2, 3]
  |> iterator.from_list
  |> zlist.of_iterator
  |> zlist.to_list
  |> should.equal([1, 2, 3])

  iterator.unfold(100, fn(n) {
    case n {
      0 -> Done
      n -> Next(element: n, accumulator: n - 1)
    }
  })
  |> zlist.of_iterator
  |> zlist.take(3)
  |> zlist.to_list
  |> should.equal([100, 99, 98])

  let all_integers_it = iterator.unfold(0, fn(n) { Next(n, n + 1) })

  all_integers_it
  |> zlist.of_iterator
  |> zlist.take(3)
  |> zlist.to_list
  |> should.equal([0, 1, 2])

  all_integers_it
  |> zlist.of_iterator
  |> zlist.take(3)
  |> zlist.to_list
  |> should.equal([0, 1, 2])

  all_integers_it
  |> zlist.of_iterator
  |> zlist.take(2)
  |> zlist.to_list
  |> should.equal([0, 1])

  all_integers_it
  |> zlist.of_iterator
  |> zlist.take(1)
  |> zlist.to_list
  |> should.equal([0])

  all_integers_it
  |> zlist.of_iterator
  |> zlist.take(0)
  |> zlist.to_list
  |> should.equal([])
}
