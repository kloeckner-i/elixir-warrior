defmodule ElixirWarrior.CLI do
  @moduledoc """
  Documentation for ElixirWarrior.
  """

  alias ElixirWarrior.{GameServer, Reloader, Tower}

  def run(_argv) do
    {:ok, game_server} = GameServer.start_link()

    # TODO: do something with the reloader (i.e., restart things)
    {:ok, file_watcher} = FileSystem.start_link(dirs: ["lib/elixir_warrior/player/"])
    {:ok, _reloader} = Reloader.start_link(file_watcher)

    :ok = GameServer.subscribe(game_server, self())

    loop()
  end

  def loop do
    receive do
      {:turn, %{current_floor: floor}} ->
        IO.puts(Tower.display_floor_plan(floor))
        loop()

      {:game_over, _state} ->
        IO.puts("Game Over")

      {:victory, _state} ->
        IO.puts("Congratulations, You've won!!!")
    end
  end
end
