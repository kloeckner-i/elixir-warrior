defmodule ElixirWarrior.Level do
  alias ElixirWarrior.Warrior

  @type coord :: {non_neg_integer, non_neg_integer}

  @callback map() :: String.t()
  @callback description() :: String.t()
  @callback tip() :: String.t()

  @callback objects() :: [term]
  @callback stairs_at() :: coord
  @callback warrior() :: Warrior.t()
end
