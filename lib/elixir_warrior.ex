defmodule ElixirWarrior do
  @moduledoc """
  Documentation for ElixirWarrior.
  """

  alias ElixirWarrior.Towers.One

  def hello do
    IO.inspect(One.floor_plan())
  end
end
