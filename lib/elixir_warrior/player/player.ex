defmodule ElixirWarrior.Player do
  def handle_turn(warrior, _player_state) do
    case warrior do
      %ElixirWarrior.Warrior{position: {3, 1}} -> {:walk, :west}
      _ -> {:walk, :east}
    end
  end
end
