defmodule Rover.Application do

  #this is the entry point of the application
  use Application

  def start(_type, _args) do
    #we will start this child process, a register for rovers and the supervisor to create or kill them
    children = [
      Supervisor.child_spec({Registry, [keys: :unique, name: Rover.Registry]}, id: :rover_registry),
      Supervisor.child_spec({Registry, [keys: :duplicate, name: Socket.Registry]}, id: :socket_registry),
      Supervisor.child_spec({RoverSupervisor, []}, id: RoverSupervisor),
      {WorldMap, []},
      Plug.Adapters.Cowboy.child_spec(:http, Rover.Web.Router, [], port: 4000),
      Plug.Adapters.Cowboy.child_spec(:http, Rover.Web.WsServer, [], port: 4001, dispatch: dispatch())
    ]

    opts = [strategy: :one_for_one, name: Application.Supervisor]
    Supervisor.start_link(children, opts)
  end

  #web socket
  defp dispatch do
    [
      {
        :_,
        [
          {"/ws", Rover.Web.WsServer, []},
          {:_, Plug.Adapter.Cowboy.Handler, {Rover.Web.Router, []}}
        ]
      }
    ]
  end
end
