defmodule WorldMap do
  use GenServer
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: WorldMap)
  end

  def init([]) do
    {:ok, %{rovers: []}}
  end

  def update_rover(name, x, y) do
    GenServer.call(__MODULE__, {:update_rover, name,x,y})
  end

  defp update_rover_list(rovers, name, x, y) do
    case Enum.find_index(rovers, fn r -> r.name == name end) do
      nil -> rovers++[%{x: x, y: y, name: name}]
      index -> List.replace_at(rovers, index, %{x: x, y: y, name: name})
    end
  end

  def handle_call({:update_rover, name, x, y}, _from, state) do
    rover_list = update_rover_list(state.rovers, name, x, y)

    case Enum.find(rover_list, fn r -> r.name != name && r.x == r && r.y == y end) do
      nil -> {:reply, :ok, %{state | rovers: rover_list}}
      rover_to_kill ->
        RoverSupervisor.kill_rover(rover_to_kill)
        new_list = List.delete(rover_list, rover_to_kill)
        {:reply, :ok, %{state | rovers: new_list}}
    end
  end

end
