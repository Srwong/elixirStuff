
iex

:an_atom

#lists are linked lists
list = [12,"hello",:foo_bar]
[1, 3, 5] ++ [2, 4] == [1, 3, 5, 2, 4]
[1, 2, 3, 4, 5] -- [1, 3, 5] == [2,4]

#this uses consecutive space in disk
tuple = {11,"book",:other_atom}

map = %{name: "emanuele", country: "italy"}

list_of_bytes = <<97,98,99,100>>
concat = "hello" <> "atom"

#anonymous function
a = fn -> 42 end

sum = fn (a, b) -> a + b end
sum.(4,5)
