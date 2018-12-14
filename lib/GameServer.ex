defmodule GameServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{time: 0})
  end

  def init(state) do
    Process.send_after(self(), :turn, 1000)
    {:ok, state}
  end

  def handle_info(:turn, %{time: time}) do
    IO.inspect("step: #{time} ")
    # Put code that handles game state here
    IO.inspect("Bring it really on!")

    Process.send_after(self(), :turn, 1000)

    {:noreply, %{time: time + 1}}
  end

  def code_change(old_vsn, state, extra) do
    IO.inspect("Code changed, reset state")
    {:ok, %{time: 0}}
  end
end
