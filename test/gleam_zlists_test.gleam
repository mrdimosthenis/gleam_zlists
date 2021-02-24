import gleam_zlists as zlist
import gleam/should

pub fn append_zlist_of_zlists_1_test() {
  let zl1 = zlist.new([1, 2, 3], fn() { [] })
  let zl2 = zlist.new([4, 5, 6], fn() { [] })
  let lz_of_zls = zlist.new([zl1, zl2], fn() { [] })

  lz_of_zls
  |> zlist.append
  |> zlist.expand
  |> should.equal([1, 2, 3, 4, 5, 6])
}

pub fn append_zlist_of_zlists_2_test() {
  let zl1 = zlist.new([1, 2, 3], fn() { [11, 12] })
  let zl2 = zlist.new([4, 5, 6], fn() { [21, 22] })
  let lz_of_zls = zlist.new([zl1, zl2], fn() { [] })

  lz_of_zls
  |> zlist.append
  |> zlist.expand
  |> should.equal([1, 2, 3, 11, 12, 4, 5, 6, 21, 22])
}
