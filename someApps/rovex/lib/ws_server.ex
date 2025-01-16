defmodule Rover.Web.WsServer do
  @behaviour :cowboy_websocket_handler
  @timeout 5*60*1000
  @registration_key "ws_server"

  def init(_, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def send_mssg_to_client(_rover, mssg) do
    Rover.Application.dispatch(
      "#{@registration_key}",
      mssg
    )
  end

  def websocket_init(_type, req, _opts) do
   #{rover, _} = :cowboy_req.qs_val(<<"rover">>, req)
   {:ok, _} = Registry.register(Socket.registry, "#{@registration_key}", [])
   state = %{}
   {:ok, req, state, @timeout}
  end

  def websocket_terminate(_reason, _req, state) do
    :ok
  end
end
