# behavior and protocols are used as some kind of polomorphism in elixir

# protocols apply to data types
# defprotocol is used as polymorphism for datatypes
defprotocol Printable do
  def to_csv(data)
end

# the second part of a protocol is its definition
# in this case we are definfing the protocol for Maps
defimpl Printable, for: Map do
  def to_csv(data) do
    Map.keys(data)
      |> Enum.map(fn x -> data[x] end)
      |> Enum.join(",")
  end
end

defimpl Printable, for: List do
  def to_csv(data) do
    Enum.map(data, fn item -> Printable.to_csv(item) end)
  end
end

# c() is used to load files in REPL
# c("./10_behavior_and_protocols.exs")
author = %{first_name: "Dave", last_name: "Thomas"}
author2 = %{first_name: "Andy", last_name: "Hunt"}
author3 = %{first_name: "Chad", last_name: "Fowler"}

IO.inspect(Printable.to_csv(author))
IO.inspect(Printable.to_csv([author, author2, author3]))

# elixir has a lot of built in protocols, such as to_string

# BEHAVIORS
# its like an interface, to ensure modules implement certain functions
defmodule TalkingAnimal do
  @callback say(msg: String.t):: {:ok}
end

defmodule Cat do
  @behaviour TalkingAnimal
  def say(str), do: "miauuu"
end

defmodule Dog do
  @behaviour TalkingAnimal
  def say(str), do: "woof"
end


# we can use funtions without knowing the real implementation
defmodule Factory do
  def get_animal(), do: Cat
end

animal = Factory.get_animal()
IO.inspect(animal.say("hello"))
