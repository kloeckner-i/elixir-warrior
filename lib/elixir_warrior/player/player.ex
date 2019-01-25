defmodule ElixirWarrior.Player do
  def handle_turn(_warrior, player_state) do

    new_player_state = Map.update(player_state, :turn, 0, &(&1 + 1))
    case new_player_state.turn do
      0 ->
        {{:walk, :east}, new_player_state}

      1 ->
        {{:walk, :east}, new_player_state}
      _ ->
        {{:attack, :east}, new_player_state}
    end
  end
end
