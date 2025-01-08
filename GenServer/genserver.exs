#GenServer has the following capabilities:
  # Creating a server process
  # Managing the server state
  # Handling requests and sending responses
  # Stopping the server
  # Handling failures

# Functions aka callbacks:
  # init/1 -> called to initialize the server. Response: {:ok, state}
  # handle_call/3 -> synchronous, when request is made to the server. Response: {:reply, response, new_state}
  # handle_cast/2 -> asynchronous, direct response is not necessary. Response: {:noreply, new_state}
  # handle_info/2 -> handler when other callbacks doesnt match the pattern. Response: {:noreply, new_state}
  # terminate/2 -> to exit, clean up resources. Response: :ok
  # code_change/3 -> to change the code of the server. Response: {:ok, new_state}

# mini redis example:
defmodule MiniRedis do
  use GenServer

  #Starts an empty hash map
  def init(_) do
    {:ok, %{}}
  end

  ###### API ######
  # these functions live in the client process instead of the server process
  # when called, they send a message to the server process.
  # this way, users doesn't need to know the PID

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end
  ###### END OF API ######

  def handle_call({:set, key, value}, _from, state) do
    {:reply, :ok, Map.merge(state, %{key => value})}
  end

  #the state in the get method is the same as it is idempotent
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.fetch(state, key), state}
  end
end

#no API usage in iex
#c("genserver.exs")
#{:ok, pid} = GenServer.start_link(MiniRedis, [])
#GenServer.call(pid, {:set, "key", "value"})
#GenServer.call(pid, {:get, "key"})
