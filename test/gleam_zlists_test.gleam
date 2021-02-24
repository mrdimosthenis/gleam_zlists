import gleam/should
import gleam_zlists as zlist

pub fn range_test() {
  zlist.range(0, 3, 1)
  |> zlist.to_list
  |> should.equal([0, 1, 2, 3])

  zlist.range(-3, 5, 2)
  |> zlist.to_list
  |> should.equal([-3, -1, 1, 3, 5])
}
