defmodule ElixirWarrior.Warrior do
  @enforce_keys [:position, :direction, :abilities]
  defstruct [:position, :direction, :abilities]

  # TODO: Add new fields based on the "senses" described here:
  # https://github.com/ryanb/ruby-warrior#commanding-the-warrior
end
