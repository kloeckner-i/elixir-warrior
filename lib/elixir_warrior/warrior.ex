defmodule ElixirWarrior.Warrior do
  @enforce_keys [:abilities, :health]
  defstruct [:abilities, :health, :distance, :spaces]
end
