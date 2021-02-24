import gleam_zlists
import gleam/should

pub fn hello_world_test() {
  gleam_zlists.hello_world()
  |> should.equal("Hello, from gleam_zlists!")
}
