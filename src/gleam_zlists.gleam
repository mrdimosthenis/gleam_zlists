pub external type ZList(a)

pub external fn new(List(a), fn() -> List(a)) -> ZList(a) =
  "zlists" "new"

pub external fn append(ZList(ZList(a))) -> ZList(a) =
  "zlists" "append"

pub external fn expand(ZList(a)) -> List(a) =
  "zlists" "expand"
