defmodule ElixirWarrior.Game do
  def start(tower, player) do
    warrior = tower.warrior()

    tick(%{tower: tower, player: player, warrior: warrior})
  end

  def tick(%{current_floor: floor, player: player, warrior: warrior} = state) do
    {x, y} = warrior_position(floor)

    # TODO: pass player state as second argument
    case player.handle_turn(warrior, nil) do
      {:walk, :east} ->
        move_position(state, {x + 1, y})

      {:walk, :west} ->
        move_position(state, {x - 1, y})

      {:walk, :south} ->
        move_position(state, {x, y + 1})

      {:walk, :north} ->
        move_position(state, {x, y - 1})

      _ ->
        raise "invalid action"
    end
  end

  defp warrior_position(floor) do
    [warrior_position] = for {position, :warrior} <- floor, do: position
    warrior_position
  end

  defp move_position(%{current_floor: floor} = state, new_position) do
    case floor[new_position] do
      nil ->
        updated_floor = update_position(floor, new_position)
        %{state | current_floor: updated_floor}

      :stairs ->
        updated_floor = update_position(floor, new_position)
        %{state | current_floor: updated_floor, status: :victory}

      # TODO: return the nature of the block
      _ ->
        state
    end
  end

  defp update_position(floor, new_position) do
    current_position = warrior_position(floor)

    floor
    |> Map.delete(current_position)
    |> Map.put(new_position, :warrior)
  end
end
