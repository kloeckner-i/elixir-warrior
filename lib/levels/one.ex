defmodule ElixirWarrior.Levels.One do
  @behaviour ElixirWarrior.Level

  def map do
    """
     --------
    |@      >|
     --------
    """
  end

  def description do
    "You see before yourself a long hallway with stairs at the end. There is nothing in the way."
  end

  def tip do
    "Call warrior.walk! to walk forward in the Player 'play_turn' method."
  end

  def objects, do: []

  def stairs_at, do: {7, 0}

  def warrior_at, do: {0, 1}
  def warrior_direction, do: :east
  def warrior_abilities, do: [:walk]
end
