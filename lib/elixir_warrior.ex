defmodule ElixirWarrior do
  @moduledoc """
  Documentation for ElixirWarrior.
  """

  alias ElixirWarrior.Levels.One

  def hello do
    IO.inspect(One.map())
  end
end
