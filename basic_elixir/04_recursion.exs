defmodule Factorial do
  def do_it(0), do: 1
  def do_it(n) do
    n * do_it(n - 1)
  end

  #this is optimized as the recursive call is the last operation
  def do_optimized(n), do: internal_do_it(n, 1)
  defp internal_do_it(0, acc), do: acc
  defp internal_do_it(n, acc), do: internal_do_it(n - 1, acc * n)
end

defmodule ListUtils do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
end

IO.puts(Factorial.do_it(5))

IO.puts(Factorial.do_optimized(5))

IO.puts(ListUtils.sum([1, 2, 3, 4, 5]))
#Redice uses an accumulator and applies the function to each element of the list
IO.puts(Enum.reduce([1, 2, 3, 4,5], fn(x, acc) -> x + acc end))

#create maps
Enum.map(["a", "b", "c"], fn x -> String.to_atom(x) end)

#filter maps
Enum.filter([1,2,3,4,5], fn(x) -> x > 2 end)
