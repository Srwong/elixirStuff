book = %{
  title: "Programming Elixir",
  author: %{
    first_name: "Dave",
    last_name: "Thomas"
  },
  year: 2018
}

IO.puts(book[:title])
IO.inspect(book[:author])
IO.inspect(book[:author][:first_name])

#Put doesn't update a map, it returns a new map
new_book = Map.put(book, :title, "Elixir 2.0")
IO.inspect(book)
IO.inspect(new_book)

new_book2 = %{ book | title:  "Programming Elixir >= 1.6"}

IO.inspect(new_book2)

Map.fetch(book, :title)

#This is the "get" method for maps. It returns a tuple
IO.inspect(Map.fetch(book, :title))
IO.inspect(Map.fetch(book, :price))
{:ok, t} = Map.fetch(book,:title)
IO.inspect(t)
