#defmodule is like a namespace to keep together your functions

defmodule MyFunctions do
    def suma(a,b) do
        a + b
    end

    def sub(a,b) do
        a - b
    end

    def div(a,b), do: a/b
end

defmodule SomeMath do
    #full import
    import MyFunctions

    #selective import (uses arity)
    #import MyFunctions, only: [sum: 2]
    def add_and_sub(a,b,c) do
        sub( suma(a,b), c )
    end
end
