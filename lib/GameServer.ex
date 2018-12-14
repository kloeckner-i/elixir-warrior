defmodule GameServer do
  use GenServer

  alias ElixirWarrior.Game
  alias ElixirWarrior.Towers.One
  alias ElixirWarrior.Player

  def start_link do
    warrior = One.warrior()
    GenServer.start_link(__MODULE__, %{time: 0, tower: One, player: Player, warrior: warrior})
  end

  def init(state) do
    Process.send_after(self(), :turn, 1000)
    {:ok, state}
  end

  def handle_info(:turn, %{time: time} = state) do
    IO.inspect("step: #{time} ")
    # Put code that handles game state here
    new_state = Game.tick(state)
    IO.inspect(new_state)

    Process.send_after(self(), :turn, 1000)

    {:noreply, %{new_state | time: time + 1}}
  end

  def code_change(old_vsn, state, extra) do
    IO.inspect("Code changed, reset state")
    {:ok, %{time: 0}}
  end
end
