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

  def parse_line(y, line) do
    chars =
      line
      |> to_charlist()
      |> Enum.with_index()

    for {ch, x} <- chars,
      ch != 32,
      do: {{x, y}, parse_square(ch)},
      into: %{}
  end

  def parse_map(map) do
    rows =
      map
      |> String.trim_trailing()
      |> String.split(~r/\R/)
      |> Enum.with_index()

    for {row, y} <- rows do
      parse_line(y, row)
    end

    # %{
    #   {1,0} => :wall,
    #   {2,0} => :wall,
    #   {1,1} => :warrior,
    #   {3,7} => :stairs
    # }
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
