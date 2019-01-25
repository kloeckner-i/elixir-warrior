defmodule ElixirWarrior.Reloader do
  use GenServer

  def start_link(watcher_pid) do
    GenServer.start_link(__MODULE__, watcher_pid)
  end

  def init(watcher_pid) do
    :ok = FileSystem.subscribe(watcher_pid)

    {:ok, watcher_pid}
  end

  def handle_info({:file_event, watcher_pid, {path, _events}}, watcher_pid) do
    relative_path = Path.relative_to_cwd(path)

    IO.puts("Reloading #{relative_path}")

    relative_path
    |> File.read!()
    |> Code.compile_string()

    {:noreply, watcher_pid}
  end

  def handle_info({:file_event, watcher_pid, :stop}, watcher_pid) do
    # YOUR OWN LOGIC WHEN MONITOR STOP
    IO.inspect("stopped watching files")
    {:noreply, watcher_pid}
  end
end
