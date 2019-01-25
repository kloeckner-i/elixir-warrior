defmodule ElixirWarrior.Game do
  @moduledoc """
  Implements the game logic for a single tick/turn by calling the player-defined
  `handle_turn/2` callback.
  """

  def tick(%{current_floor: floor, player: player, warrior: warrior, player_state: player_state} = state) do
    position = warrior_position(floor)

    # TODO: update the warrior with new information from the floor
    # TODO: pass player state as second argument
    {action, player_state} = player.handle_turn(warrior, player_state)
    new_state = %{state | player_state: player_state}

    case action do
      {:walk, :east} ->
        move_position(new_state, new_position(:east , position))

      {:walk, :west} ->
        move_position(new_state, new_position(:west , position))

      {:walk, :south} ->
        move_position(new_state, new_position(:south , position))

      {:walk, :north} ->
        move_position(new_state, new_position(:north , position))

      {:attack, :east} ->
        attack(new_state, new_position(:east , position))

      {:attack, :west} ->
        attack(new_state, new_position(:west , position))

      {:attack, :south} ->
        attack(new_state, new_position(:south , position))

      {:attack, :north} ->
        attack(new_state, new_position(:north , position))

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
  def walk() do

  end

  def new_position(:east , {x, y}) do
    {x + 1, y}
  end

  def new_position(:west , {x, y}) do
    {x - 1, y}
  end

  def new_position(:south , {x, y}) do
    {x, y + 1}
  end

  def new_position(:north , {x, y}) do
    {x, y - 1}
  end

  defp warrior_position(floor) do
    [warrior_position] = for {position, :warrior} <- floor, do: position
    warrior_position
  end

  defp move_position(%{current_floor: floor, warrior: warrior} = state, new_position) do
    case floor[new_position] do
      nil ->
        updated_floor = move_warrior(floor, new_position)
        %{state | current_floor: updated_floor, warrior: %{warrior | position: new_position}}

      :stairs ->
        updated_floor = move_warrior(floor, new_position)
        %{state | current_floor: updated_floor, status: :victory}

      # TODO: return the nature of the block
      _ ->
        state
    end
  end

  defp attack(%{current_floor: floor} = state, new_position) do
    case floor[new_position] do
      {:sludge, hp} when hp > 1 ->
        updated_floor = Map.put(floor, new_position, {:sludge, hp - 1})
        %{state | current_floor: updated_floor}
      {:sludge, 1} ->
        updated_floor = Map.put(floor, new_position, :space)
        %{state | current_floor: updated_floor}

      # TODO: return the nature of the block
      _ ->
        state
    end
  end

  defp move_warrior(floor, new_position) do
    current_position = warrior_position(floor)

    floor
    |> Map.delete(current_position)
    |> Map.put(new_position, :warrior)
  end
end
