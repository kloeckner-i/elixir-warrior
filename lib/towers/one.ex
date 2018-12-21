defmodule ElixirWarrior.Towers.One do
  @behaviour ElixirWarrior.Tower

  alias ElixirWarrior.Warrior

  def map do
    """
     --------
    |@       |
    |        |
    |       >|
     --------
    """
  end

  def parse_square(?-), do: :horizontal_wall
  def parse_square(?|), do: :vertical_wall
  def parse_square(?@), do: :warrior
  def parse_square(?>), do: :stairs


  def display_square(:horizontal_wall), do: "-"
  def display_square(:vertical_wall), do: "|"
  def display_square(:warrior), do: "@"
  def display_square(:stairs), do: ">"
  def display_square(:space), do: " "


  def parse_line(y, line) do
    chars =
      line
      |> to_charlist()
      |> Enum.with_index()

    for {ch, x} <- chars,
      ch != ?\s,
      do: {{x, y}, parse_square(ch)},
      into: %{}
  end

  def parse_map(map) do
      map
      |> String.trim_trailing()
      |> String.split(~r/\R/)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc -> Map.merge(acc,parse_line(y, line)) end)
  end

  def display(parsed_map) do
    for y <- 0..5, x <- 0..10 do
      Map.get(parsed_map, {x,y}, :space)
      |> display_square()
      |> new_line(x)
    end
    |> Enum.join()
    |> IO.puts()
  end

  def new_line(char, 10) do
    char <> "\n"
  end

  def new_line(char , _x) do
    char
  end

  def description do
    "You see before yourself a long hallway with stairs at the end. There is nothing in the way."
  end

  def tip do
    "Call warrior.walk! to walk forward in the Player 'play_turn' method."
  end

  def objects, do: []

  def stairs_at, do: {7, 3}

  def bounds, do: {{0,0}, {7,3}}

  def warrior do
    %Warrior{
      position: {0, 0},
      direction: :east,
      abilities: [:walk]
    }
  end
end
