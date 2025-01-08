defmodule SupervisorExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: SupervisorExample.Worker.start_link(arg)
      # {SupervisorExample.Worker, arg}
      {MyServer, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SupervisorExample.Supervisor]
    Supervisor.start_link(children, opts)

    #Run with: iex -S mix
    #Call it: MyServer.ping
  end
end
