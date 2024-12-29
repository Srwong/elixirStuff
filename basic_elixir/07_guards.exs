#applied to functions. It filters the input to the function
defmodule Divisions do

  #guard will check for greater than 0, and is float or integer
  def div_by_10(n) when(n > 0) and (is_float(n) or is_integer(n)) do
    n / 10
  end
end

IO.puts(Divisions.div_by_10(100))
IO.puts(Divisions.div_by_10(100.0))
IO.puts(Divisions.div_by_10("100"))
