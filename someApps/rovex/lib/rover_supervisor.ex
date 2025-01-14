defmodule RoverSupervisor do
  use DynamicSupervisor

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def create_rover(name, x, y, dir) do
    DynamicSupervisor.start_child(__MODULE__, {Rover, {x,y,dir,name}})
  end

  def kill_rover(rover) do
    pid = RegistryHelper.get_pid(rover.name)
    DynamicSupervisor.terminate_child(__MODULE__, pid)
  end
end
