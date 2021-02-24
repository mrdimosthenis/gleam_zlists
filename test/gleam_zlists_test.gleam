import gleam/should

pub fn true_test() {
  True
  |> should.equal(True)
}
