defmodule Mix.Tasks.Start do
  @moduledoc false

  use Mix.Task

  alias ElixirWarrior.CLI

  @shortdoc "Let's go and fight"
  def run(argv) do
    CLI.run(argv)
  end
end
