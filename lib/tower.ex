defmodule ElixirWarrior.Tower do
  alias ElixirWarrior.Warrior

  @type coord :: {non_neg_integer, non_neg_integer}

  @callback floor_plan() :: String.t()
  @callback description() :: String.t()
  @callback tip() :: String.t()

  @callback warrior() :: Warrior.t()

  def parse_cell(?-), do: :horizontal_wall
  def parse_cell(?|), do: :vertical_wall
  def parse_cell(?@), do: :warrior
  def parse_cell(?>), do: :stairs

  def display_cell(:horizontal_wall), do: "-"
  def display_cell(:vertical_wall), do: "|"
  def display_cell(:warrior), do: "@"
  def display_cell(:stairs), do: ">"
  def display_cell(:space), do: " "

  def parse_line(y, line) do
    chars =
      line
      |> to_charlist()
      |> Enum.with_index()

    for {ch, x} <- chars,
        ch != ?\s,
        do: {{x, y}, parse_cell(ch)},
        into: %{}
  end

  def parse_floor_plan(floor_plan) do
    floor_plan
    |> String.trim_trailing()
    |> String.split(~r/\R/)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc -> Map.merge(acc, parse_line(y, line)) end)
  end

  def display(parsed_floor_plan) do
    for y <- 0..5, x <- 0..10 do
      Map.get(parsed_floor_plan, {x, y}, :space)
      |> display_cell()
      |> new_line(x)
    end
    |> Enum.join()
    |> IO.puts()
  end

  def new_line(char, 10) do
    char <> "\n"
  end

  def new_line(char, _x) do
    char
  end
end
