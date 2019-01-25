defmodule ElixirWarrior.Reloader do
  @moduledoc """
  TODO: This gen_server should be in charge of reloading the player module when
  the file changes.

  Other processes should be able to subscribe to :reload events and handle them
  accordingly.
  """

  use GenServer

  ### Client

  def start_link(watcher_pid) do
    GenServer.start_link(__MODULE__, watcher_pid)
  end

  ### Server (callbacks)

  @impl true
  def init(watcher_pid) do
    :ok = FileSystem.subscribe(watcher_pid)

    {:ok, watcher_pid}
  end

  @impl true
  def handle_info({:file_event, watcher_pid, {path, _events}}, watcher_pid) do
    relative_path = Path.relative_to_cwd(path)

    IO.puts("Reloading #{relative_path}")

    relative_path
    |> File.read!()
    |> Code.compile_string()

    {:noreply, watcher_pid}
  end

  def handle_info({:file_event, watcher_pid, :stop}, watcher_pid) do
    # TODO: Decide what to do when the monitor stops
    # Maybe we want to crash the reloader and force the file watcher to reload
    # via the supervision tree.
    IO.inspect("stopped watching files")
    {:noreply, watcher_pid}
  end
end
