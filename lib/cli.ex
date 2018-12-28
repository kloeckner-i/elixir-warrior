defmodule ElixirWarrior.CLI do
  @moduledoc """
  Documentation for ElixirWarrior.
  """

  @shortdoc "Let's go and fight"
  def run(_argv) do
    GameServer.start_link()
  end
end
