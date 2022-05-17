import gleam_zlists/interop
import gleeunit/should

pub fn recurrent_3_test() {
  interop.recurrent_3(1, 0, fn(a, b) { #(a + b, a) })
  |> interop.take(10, _)
  |> interop.expand
  |> should.equal([1, 1, 2, 3, 5, 8, 13, 21, 34, 55])
}

pub fn append_zlist_of_zlists_1_test() {
  let zl1 = interop.new_1([1, 2, 3], fn() { [] })
  let zl2 = interop.new_1([4, 5, 6], fn() { [] })
  let lz_of_zls = interop.new_1([zl1, zl2], fn() { [] })

  lz_of_zls
  |> interop.append
  |> interop.expand
  |> should.equal([1, 2, 3, 4, 5, 6])
}

pub fn append_zlist_of_zlists_2_test() {
  let zl1 = interop.new_1([1, 2, 3], fn() { [11, 12] })
  let zl2 = interop.new_1([4, 5, 6], fn() { [21, 22] })
  let lz_of_zls = interop.new_1([zl1, zl2], fn() { [] })

  lz_of_zls
  |> interop.append
  |> interop.expand
  |> should.equal([1, 2, 3, 11, 12, 4, 5, 6, 21, 22])
}
