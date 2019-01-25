defmodule ElixirWarrior.GameServer do
  use GenServer

  alias ElixirWarrior.{Game, Player, Tower, Towers}

  @default_tower Towers.One
  @default_player Player

  ### Client

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def subscribe(server_pid, subscriber_pid) do
    GenServer.call(server_pid, {:subscribe, subscriber_pid})
  end

  ### Server (callbacks)

  @impl true
  def init(opts) do
    tower = Keyword.get(opts, :tower, @default_tower)
    player = Keyword.get(opts, :player, @default_player)

    Process.send_after(self(), :turn, 1000)

    # TODO: consider initializing "game" state via a `Game.init/1` or
    # `Game.new/1` function.
    #
    # This server shouldn't know too much about the game itself, it's only
    # in charge of ticks/turns and subscriptions.
    {:ok,
     %{
       turns: 0,
       tower: tower,
       player: player,
       warrior: tower.warrior(),
       current_floor: Tower.parse_floor_plan(tower.floor_plan()),
       status: :active,
       player_state: %{},
       subscribers: []
     }}
  end

  @impl true
  def handle_info(:turn, %{turns: turns, subscribers: subscribers} = state) do
    new_state = %{Game.tick(state) | turns: turns + 1}

    case new_state.status do
      :active ->
        notify_subscribers(subscribers, {:turn, new_state})
        Process.send_after(self(), :turn, 1000)
        {:noreply, new_state}

      status when status in [:game_over, :victory] ->
        notify_subscribers(subscribers, {status, new_state})
        {:stop, :normal, new_state}
    end
  end

  @impl true
  def handle_call({:subscribe, pid}, _from, state) do
    {:reply, :ok, %{state | subscribers: [pid | state.subscribers]}}
  end

  defp notify_subscribers(subscribers, message) do
    for pid <- subscribers, do: send(pid, message)
  end
end
