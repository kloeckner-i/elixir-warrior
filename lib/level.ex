defmodule ElixirWarrior.Level do
  @type coord :: {non_neg_integer, non_neg_integer}

  @type direction :: :east | :west | :north | :south

  @callback map() :: String.t()
  @callback description() :: String.t()
  @callback tip() :: String.t()

  @callback objects() :: [term]
  @callback stairs_at() :: coord
  @callback warrior_at() :: coord
  @callback warrior_direction() :: direction
  @callback warrior_abilities() :: [atom]
end
