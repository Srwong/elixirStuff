defmodule AsyncMath do
  def start() do
    #start a process and waits for the tuple declared
    receive do
      {:sum, [x,y], pid} ->
        #send the sum to the pid
        send(pid, {pid, x+y})
    end
    start()
  end
end

#used as an example for process communication
#Run this in the terminal with iex to see the results

#c("async_math.exs")
#pid = spawn(AsyncMath, :start, [])
#Process.alive?(pid)
#send(pid, {:sum, [1, 3], self})
#Process.alive?(pid)
#flush #prints the inbox of the proqcess
