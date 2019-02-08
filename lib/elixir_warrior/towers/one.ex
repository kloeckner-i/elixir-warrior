defmodule ElixirWarrior.Towers.One do
  @behaviour ElixirWarrior.Tower

  alias ElixirWarrior.Warrior

  def floor_plan do
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

  def warrior do
    %Warrior{
      abilities: [:walk],
      health: 100
    }
  end
end
