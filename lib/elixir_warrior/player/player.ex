defmodule ElixirWarrior.Player do
  def handle_turn(_warrior, _player_state) do
    {:walk, :east}
  end
end
