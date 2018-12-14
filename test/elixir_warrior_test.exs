defmodule ElixirWarriorTest do
  use ExUnit.Case
  doctest ElixirWarrior

  test "greets the world" do
    assert ElixirWarrior.hello() == :world
  end
end
