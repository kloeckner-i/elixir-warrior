defmodule ElixirWarrior.Towers.Three do
  @behaviour ElixirWarrior.Tower

  alias ElixirWarrior.Warrior

  def floor_plan do
    """
     ------
    |      |
    |@     |
    |      |
    |  >   |
     ------
    """
  end

  def description do
    "Silence. The room feels large, but empty. Luckily you have a map of this tower to help find the stairs."
  end

  def tip do
    "Use warrior.direction_of_stairs to determine which direction stairs are located. Pass this to warrior.walk! to walk in that direction."
  end

  def warrior do
    %Warrior{
      abilities: [:walk],
      health: 10
    }
  end
end
