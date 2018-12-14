defmodule Mix.Tasks.Start do
  @moduledoc false

  use Mix.Task

  @shortdoc "Let's go and fight"
  def run(argv) do
    IO.inspect(ElixirWarrior.hello())
  end
end
