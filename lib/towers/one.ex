defmodule ElixirWarrior.Towers.One do
  @behaviour ElixirWarrior.Tower

  alias ElixirWarrior.Warrior

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

  def warrior do
    %Warrior{
      position: {0, 0},
      direction: :east,
      abilities: [:walk]
    }
  end
end
