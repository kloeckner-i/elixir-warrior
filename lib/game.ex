defmodule ElixirWarrior.Game do
  alias ElixirWarrior.Warrior

  def start(tower, player) do
    warrior = tower.warrior()

    tick(%{tower: tower, player: player, warrior: warrior})
  end

  def tick(%{tower: tower, player: player, warrior: warrior} = state) do
    {x, y} = warrior.position

    case player.handle_turn(warrior) do
      {:walk, :east} ->
        %{state | warrior: %Warrior{warrior | position: {x + 1, y}}}

      _ ->
        raise "invalid action"
    end
  end
end
