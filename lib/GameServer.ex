defmodule GameServer do
  use GenServer

  alias ElixirWarrior.Game
  alias ElixirWarrior.Towers.One
  alias ElixirWarrior.Tower

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(_args) do
    warrior = One.warrior()
    {:ok, watcher_pid} = FileSystem.start_link(dirs: ["lib/player/"], name: :my_monitor_name)
    FileSystem.subscribe(watcher_pid)
    Process.send_after(self(), :turn, 1000)

    {:ok,
     %{
       time: 0,
       tower: One,
       player: ElixirWarrior.Player,
       warrior: warrior,
       watcher_pid: watcher_pid,
       current_floor: Tower.parse_floor_plan(One.floor_plan()),
       status: :active
     }}
  end

  def handle_info(:turn, %{time: time} = state) do
    IO.inspect("step: #{time} ")
    # Put code that handles game state here
    new_state = Game.tick(state)

    case new_state do
      %{status: :victory} ->
        IO.puts("Congratulations, You've won!!!")

      %{status: :game_over} ->
        IO.puts("Game Over")

      %{status: :active} = new_state ->
        IO.puts(Tower.display(new_state.current_floor))
        Process.send_after(self(), :turn, 1000)
    end

    {:noreply, %{new_state | time: time + 1}}
  end

  def handle_info(
        {:file_event, watcher_pid, {path, _events}},
        %{watcher_pid: watcher_pid} = state
      ) do
    path
    |> Path.relative_to_cwd()
    |> reloading
    |> File.read!()
    |> Code.compile_string()

    {:noreply, state}
  end

  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    # YOUR OWN LOGIC WHEN MONITOR STOP
    IO.inspect("stopped watching files")
    {:noreply, state}
  end

  def code_change(old_vsn, state, extra) do
    IO.inspect("Code changed, reset state")
    {:ok, %{time: 0}}
  end

  def reloading(path) do
    IO.puts("Reloading #{path}")
    path
  end
end
