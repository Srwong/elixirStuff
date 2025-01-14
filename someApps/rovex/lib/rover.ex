defmodule Rover do
  use GenServer

  defstruct [:x, :y, :dir, :name]

  def start_link({x,y,dir,name}) do
    GenServer.start_link(__MODULE__, {x,y,dir,name}, name: String.to_atom(name))
  end

  def init({x,y,dir,name}) do
    {:ok, %Rover{x: x, y: y, dir: dir, name: name}}
  end

  def get_state(name) do
    GenServer.call(String.to_atom(name), :get_state)
  end

  def handle_call(:get_state, _from, state) do
    {:reply, {:ok,{state.x,state.y,state.dir}}, state}
  end

  #thhese are constants
  @world_width 100
  @world_heigth 100
  def go_forward(name) do
    GenServer.cast(RegistryHelper.create_key(name), :go_forward)
  end
  def handle_call(:go_forward, state) do
    new_state = case state.dir do
      # the pipe operator is used to merge the states
      :N -> %Rover{ state | x: state.x, y: mod(state.y +1, @world_heigth)}
      :S -> %Rover{ state | x: state.x, y: mod(state.y - 1, @world_heigth)}
      :E -> %Rover{ state | x: mod(state.x + 1, @world_width), y: state.y}
      :W -> %Rover{ state | x: mod(state.x - 1, @world_width), y: state.y}
    end

    {:no_reply, new_state}
  end

  def go_backward(name) do
    GenServer.cast(RegistryHelper.create_key(name), :go_backward)
  end
  def handle_call(:go_backward, state) do
    new_state = case state.dir do
      :N -> %Rover{ state | x: state.x, y: mod(state.y - 1, @world_heigth)}
      :S -> %Rover{ state | x: state.x, y: mod(state.y + 1, @world_heigth)}
      :E -> %Rover{ state | x: mod(state.x - 1, @world_width), y: state.y}
      :W -> %Rover{ state | x: mod(state.x + 1, @world_width), y: state.y}
    end

    {:no_reply, new_state}
  end

  def rotate_left(name) do
    GenServer.cast(RegistryHelper.create_key(name), :rotate_left)
  end
  def handle_call(:rotate_left, state) do
    new_state = case state.dir do
      :N -> %Rover{ state | dir: :W}
      :S -> %Rover{ state | dir: :E}
      :E -> %Rover{ state | dir: :N}
      :W -> %Rover{ state | dir: :S}
    end

    {:no_reply, new_state}
  end

  def rotate_right(name) do
    GenServer.cast(RegistryHelper.create_key(name), :rotate_right)
  end
  def handle_call(:rotate_right, state) do
    new_state = case state.dir do
      :N -> %Rover{ state | dir: :E}
      :S -> %Rover{ state | dir: :W}
      :E -> %Rover{ state | dir: :S}
      :W -> %Rover{ state | dir: :N}
    end

    {:no_reply, new_state}
  end
end
