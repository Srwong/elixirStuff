defmodule Rover.Web.Router do
  use Plug.Router

  #used to set Poison as the json decoder, it parses json to maps
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  #used to match the request to the correct route
  plug(:match)
  #used to dispatch the request to the correct controller
  plug(:dispatch)

  #first handler, /ping route using GET method
  get "/ping" do
    send_resp(conn, 200, Poison.encode!(%{message: "pong"}))
  end

  post "/rover" do
    case RoverSupervisor.create_rover(
      conn.body_params["name"],
      conn.body_params["x"],
      conn.body_params["y"],
      conn.body_params["dir"]
    ) do
      {:ok, _} -> send_resp(conn, 201, Poison,encode!(%{message: "created rover #{rover_name}"}))
      {:error, :already_started} -> send_resp(conn, 401, encode(%{message: "rover already exists"}))
      _ -> send_resp(conn, 500, encode(%{message: "error creating rover"}))
    end
  end

  post "/command" do
    rover = conn.body_params["name"]
    command = String.to_atom(conn.body_params["command"])
    Rover.send_command(rover, command)
    send_resp(conn, 200, Poison.encode!(%{message: "command sent"}))
  end

  #default handler
  match(_) do
    send_resp(conn, 404,"")
  end
end
