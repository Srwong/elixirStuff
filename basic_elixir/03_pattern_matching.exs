#Pattern matching first use case is to avoid conditionals

defmodule Greet do
  def greet("") do
    IO.puts("No message")
  end

  #evaluated from top to bottom, this at first place would catch all the inputs
  def greet(text), do: IO.puts("#{text}")
  def greet(), do: IO.puts("Hello, World!")
end


Greet.greet("Custom message")
Greet.greet("")
Greet.greet()

#we can also decompose lists
#by separating
[head | tail ] = [1,2,3,4,5]
IO.puts(head)
IO.inspect(tail)

#and peer element
[a,b,c] = [1,2,3]
IO.puts(a)
IO.puts(b)
IO.puts(c)

[a,b|c] = [1,2,3,4,5]
IO.puts(a)
IO.puts(b)
IO.inspect(c)

#it also works on maps
%{a: map1, b: map2, c: map3} = %{a: 4, b: "something", c: head}
IO.puts(map1)
IO.puts(map2)
IO.puts(map3)
