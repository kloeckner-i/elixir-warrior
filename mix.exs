defmodule ElixirWarrior.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_warrior,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: ElixirWarrior.CLI],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:file_system, "~> 0.2"}
    ]
  end
end
