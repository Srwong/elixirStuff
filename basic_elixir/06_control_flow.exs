a = 2

if(a == 1) do
  IO.puts("a is 1")
else
  IO.puts("a is not 1")
end

b  = if a == true do
  "a is true"
else
  "a is not true"
end

IO.puts(b)

language = "sone"
welcome_message = case language do
  "spanish" -> "Bienvenido"
  "french" -> "Bienvenue"
  "german" -> "Willkommen"
  _ -> "Welcome"
end

IO.puts(welcome_message)
