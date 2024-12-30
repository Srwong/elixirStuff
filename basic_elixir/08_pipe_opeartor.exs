# |>
# the pipe operator is used to chain functions together
# it passes the result of the previous function to the next function as first argument

# Example
IO.puts Enum.reduce(Enum.map(Enum.filter([1, 3, 5, 7, 8, 9], fn x -> x > 5 end), fn x -> x + 10 end), fn acc, x -> acc + x end)

# With pipe operator
[1, 3, 5, 7, 8, 9]
    |> Enum.filter(fn x -> x > 5 end)
    |> Enum.map(fn x -> x + 10 end)
    |> Enum.reduce(fn acc, x -> acc + x end)
    |> IO.puts
