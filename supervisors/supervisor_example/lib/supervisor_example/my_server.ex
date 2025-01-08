defmodule MyServer do
  use GenServer

  def init(), do: {:ok, []}
  def start_link([]), do: GenServer.start_link(__MODULE__,[], name: __MODULE__)
  def ping(), do: GenServer.call(__MODULE__, :ping)
  def crash(), do: GenServer.call(__MODULE__, :crash)

  def handle_call(:ping, _from, state) do
    {:reply, :pong, state}
  end

  def handle_call(:crash, _from, state) do
    throw "Bang!"
    {:reply, :error, state}
  end

  def terminate(reason, state) do

    # dump the state
    # Code to save the state into db or a file for error recovery

  end
end
