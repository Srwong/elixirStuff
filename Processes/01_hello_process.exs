defmodule HelloProcess do
  def say(msg), do: IO.puts("Hello #{msg}")
end

#c("hello_process.exs")

#with spawn we can execute this with a new process
#spawn(HelloProcess, :say, [“adam”])

#it returns a process with 3 partes A.B.C
# A is the node number, 0 is the default and indicates "local machine"
# B is the process number
# C is the message number

#Process.alive?(pid) #returns true if the process is alive
