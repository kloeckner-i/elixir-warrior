defmodule ElixirWarrior.Warrior do
  @enforce_keys [:position, :direction, :abilities]
  defstruct [:position, :direction, :abilities]
end
