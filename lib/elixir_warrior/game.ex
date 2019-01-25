defmodule ElixirWarrior.Game do
  @moduledoc """
  Implements the game logic for a single tick/turn by calling the player-defined
  `handle_turn/2` callback.
  """

  def tick(%{current_floor: floor, player: player, warrior: warrior} = state) do
    {x, y} = warrior_position(floor)

    # TODO: update the warrior with new information from the floor
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

      # TODO: handle {:attack, direction}
      # TODO: handle :rest
      # TODO: handle {:bind, direction} ?? what does this do
      # TODO: handle {:rescue, direction}
    end

    # TODO: we could return a summary of the action we performed via the state.
    # %{state | last_action: "Walked 1 space (east)"}
    # %{state | last_action: "Ran into a wall (east)"}
    # %{state | last_action: "Rescued captive (west)"}
    # %{state | last_action: "Attacked enemy for 1 damage (5 HP remaining) (west)"}
  end

  defp warrior_position(floor) do
    [warrior_position] = for {position, :warrior} <- floor, do: position
    warrior_position
  end

  defp move_position(%{current_floor: floor, warrior: warrior} = state, new_position) do
    case floor[new_position] do
      nil ->
        updated_floor = update_position(floor, new_position)
        %{state | current_floor: updated_floor, warrior: %{warrior | position: new_position}}

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
