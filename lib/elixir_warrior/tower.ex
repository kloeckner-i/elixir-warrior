defmodule ElixirWarrior.Tower do
  alias ElixirWarrior.Warrior

  @type coord :: {non_neg_integer, non_neg_integer}

  @callback floor_plan() :: String.t()
  @callback description() :: String.t()
  @callback tip() :: String.t()

  @callback warrior() :: Warrior.t()

  @doc """
  Parses a binary represenation of a floor plan into a map.

  ## Examples

      iex> Tower.parse_floor_plan(
      ...>   \"""
      ...>   -----
      ...>   |@ >|
      ...>   -----
      ...>   \"""
      ...> )
      %{
        {0, 0} => :horizontal_wall,
        {0, 1} => :vertical_wall,
        {0, 2} => :horizontal_wall,
        {1, 0} => :horizontal_wall,
        {1, 1} => :warrior,
        {1, 2} => :horizontal_wall,
        {2, 0} => :horizontal_wall,
        {2, 2} => :horizontal_wall,
        {3, 0} => :horizontal_wall,
        {3, 1} => :stairs,
        {3, 2} => :horizontal_wall,
        {4, 0} => :horizontal_wall,
        {4, 1} => :vertical_wall,
        {4, 2} => :horizontal_wall
      }
  """
  def parse_floor_plan(text) do
    text
    |> String.trim_trailing()
    |> String.split(~r/\R/)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc -> Map.merge(acc, parse_line(y, line)) end)
  end

  defp parse_line(y, line) do
    chars = line |> to_charlist() |> Enum.with_index()

    for {ch, x} <- chars,
        ch != ?\s,
        do: {{x, y}, parse_cell(ch)},
        into: %{}
  end

  defp parse_cell(?-), do: :horizontal_wall
  defp parse_cell(?|), do: :vertical_wall
  defp parse_cell(?@), do: :warrior
  defp parse_cell(?>), do: :stairs
  defp parse_cell(?s), do: {:sludge, 12}
  defp parse_cell(?S), do: {:thick_sludge, 24}


  @doc """
  Converts a map representation of a floor plan to a binary.

  ## Examples

      iex> Tower.display_floor_plan(
      ...>   %{
      ...>     {0, 0} => :horizontal_wall,
      ...>     {0, 1} => :vertical_wall,
      ...>     {0, 2} => :horizontal_wall,
      ...>     {1, 0} => :horizontal_wall,
      ...>     {1, 1} => :warrior,
      ...>     {1, 2} => :horizontal_wall,
      ...>     {2, 0} => :horizontal_wall,
      ...>     {2, 2} => :horizontal_wall,
      ...>     {3, 0} => :horizontal_wall,
      ...>     {3, 1} => :stairs,
      ...>     {3, 2} => :horizontal_wall,
      ...>     {4, 0} => :horizontal_wall,
      ...>     {4, 1} => :vertical_wall,
      ...>     {4, 2} => :horizontal_wall
      ...>   }
      ...> )
      "-----\\n|@ >|\\n-----"
  """
  def display_floor_plan(plan) do
    x_max = Enum.max(for {{x, _}, _} <- plan, do: x)
    y_max = Enum.max(for {{_, y}, _} <- plan, do: y)

    for y <- 0..y_max do
      display_row(plan, 0..x_max, y)
    end
    |> Enum.join("\n")
  end

  defp display_row(plan, xs, y) do
    for x <- xs do
      plan
      |> Map.get({x, y}, :space)
      |> display_cell()
    end
    |> Enum.join()
  end

  defp display_cell(:horizontal_wall), do: "-"
  defp display_cell(:vertical_wall), do: "|"
  defp display_cell(:warrior), do: "@"
  defp display_cell({:sludge, _}), do: "s"
  defp display_cell({:thick_sludge, _}), do: "S"
  defp display_cell(:stairs), do: ">"
  defp display_cell(:space), do: " "
end
