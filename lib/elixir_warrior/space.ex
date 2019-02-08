defmodule ElixirWarrior.Space do
  @enforce_keys [:empty?, :stairs?, :enemy?, :captive?, :wall?, :ticking?, :golem?]
  defstruct [:empty?, :stairs?, :enemy?, :captive?, :wall?, :ticking?, :golem?]

end
