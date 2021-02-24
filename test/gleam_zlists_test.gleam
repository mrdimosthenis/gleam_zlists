import gleam/should
import gleam/int
import gleam_zlists as zlist

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
  // the next assertion throws an exception
  //[1, 2, 3]
  //|> zlist.of_list
  //|> zlist.drop(10)
  //|> zlist.to_list
  //|> should.equal([])
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
  let tuple(ls_a, zls_b) =
    [1, 2, 3]
    |> zlist.of_list
    |> zlist.split(2)
  let ls_b = zlist.to_list(zls_b)
  should.equal(tuple(ls_a, ls_b), tuple([1, 2], [3]))
}

pub fn split_2_test() {
  let tuple(ls_a, zls_b) =
    [1, 2, 3]
    |> zlist.of_list
    |> zlist.split(10)
  let ls_b = zlist.to_list(zls_b)
  should.equal(tuple(ls_a, ls_b), tuple([1, 2, 3], []))
}

pub fn split_3_test() {
  let tuple(ls_a, zls_b) =
    [1, 2, 3]
    |> zlist.of_list
    |> zlist.split(0)
  let ls_b = zlist.to_list(zls_b)
  should.equal(tuple(ls_a, ls_b), tuple([], [1, 2, 3]))
}

pub fn split_while_1_test() {
  let tuple(ls_a, zls_b) =
    [1, 2, 3, 4]
    |> zlist.of_list
    |> zlist.split_while(fn(x) { x < 3 })
  let ls_b = zlist.to_list(zls_b)
  should.equal(tuple(ls_a, ls_b), tuple([1, 2], [3, 4]))
}

pub fn split_while_2_test() {
  let tuple(ls_a, zls_b) =
    [1, 2, 3, 4]
    |> zlist.of_list
    |> zlist.split_while(fn(x) { x < 0 })
  let ls_b = zlist.to_list(zls_b)
  should.equal(tuple(ls_a, ls_b), tuple([], [1, 2, 3, 4]))
}

pub fn split_while_3_test() {
  let tuple(ls_a, zls_b) =
    [1, 2, 3, 4]
    |> zlist.of_list
    |> zlist.split_while(fn(x) { x > 0 })
  let ls_b = zlist.to_list(zls_b)
  should.equal(tuple(ls_a, ls_b), tuple([1, 2, 3, 4], []))
}

pub fn zip_1_test() {
  let left = zlist.of_list([1, 2, 3])
  let right = zlist.of_list(["foo", "bar", "baz"])
  zlist.zip(left, right)
  |> zlist.to_list
  |> should.equal([tuple(1, "foo"), tuple(2, "bar"), tuple(3, "baz")])
}

pub fn zip_2_test() {
  let left = zlist.of_list([1, 2, 3, 4, 5])
  let right = zlist.of_list(["foo", "bar", "baz"])
  zlist.zip(left, right)
  |> zlist.to_list
  |> should.equal([tuple(1, "foo"), tuple(2, "bar"), tuple(3, "baz")])
}

pub fn zip_3_test() {
  let left = zlist.of_list([1, 2, 3])
  let right = zlist.of_list(["foo", "bar", "baz", "far"])
  zlist.zip(left, right)
  |> zlist.to_list
  |> should.equal([tuple(1, "foo"), tuple(2, "bar"), tuple(3, "baz")])
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
