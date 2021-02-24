import erl/interface as api

type ZList(t) =
  api.ZList(t)

/// Converts a `list` to `ZList`.
///
pub fn of_list(list: List(t)) -> ZList(t) {
  api.new(list, fn() { [] })
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
/// The `step` should be positive.
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
