#Elixir is dynamic, thus it cannot check at compile time the types of the variables.
#However, it is possible to specify the types of the variables in the function definition.

#@spec is used before the function

defmodule Math do
    # Here it indicates it receives an integer and returns an integer
    @spec divide(integer, integer) :: {:ok, integer} | {:error, String.t}
    def divide(a,b) do
        if b == 0 do
         {:error, "Division by zero"}
        else
            {:ok, div(a,b)}
        end
    end
end

IO.inspect(Math.divide(10,3))

defmodule Customer do
    # @type is used to define an alias
    @type entity_id:: integer
    # here we define Customer, t is a convention to indicate it will define itself
    @type t::%Customer{id: entity_id(), first_name: String.t, last_name: String.t}
    # for ease of use and default values the defstruct is declared
    defstruct id: 0, first_name: nil, last_name: nil
end

defmodule CustomerDao do
    @type reason:: String.t()
    @spec get_customer(Customer.entity_id()) :: {:ok, Customer} | {:error, reason}
    def get_customer(id) do
      IO.puts("Getting customer with id: #{id}")
      #some logic to get the customer
      {:ok, %Customer{id: id, first_name: "John", last_name: "Doe"}}
    end

    @spec add_customer(String.t(), String.t()) :: {:ok, nil} | {:error, reason}
    def add_customer(first_name, last_name) do
      IO.puts("Adding customer: #{first_name} #{last_name}")
      #some logic to add the customer
      {:ok, nil}
    end
end

IO.inspect(CustomerDao.get_customer(1))
