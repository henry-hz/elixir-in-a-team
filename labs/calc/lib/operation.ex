defmodule Operation do
  @moduledoc """
  Data strucutre to pipe a mathematical operation between two terms
  see [here](https://elixir-lang.org/getting-started/structs.html) for more details
  on how to deal with structs.
  """

  @typedoc "the term that will receive an addition"
  @type term1 :: integer | float

  @typedoc "the term that will be added over the first term"
  @type term2 :: integer | float

  @typedoc "result is the addition"
  @type result :: integer | float

  @typedoc "function that will in fact make the calculation"
  @type calc_operator :: fun()



  defstruct name: nil, term1: nil, term2: nil, result: nil, calc_operator: nil

  @typedoc "Fields of an operation data structure"
  @type operation :: %Operation{
    name:           String.t,
    term1:          integer | float,
    term2:          integer | float,
    result:         integer | float,
    calc_operator:  calc_operator
  }



  @doc "add the operation name in our data structure"
  @spec set_name(operation, String.t) :: operation
  def set_name(operation, name), do: %{operation | name: name}

  @doc "add the first term"
  @spec set_term1(operation, term1) :: operation
  def set_term1(operation, term1), do: %{operation | term1: term1}

  @doc "add the term2"
  @spec set_term2(operation, term2) :: operation
  def set_term2(operation, term2), do: %{operation | term2: term2}

  @doc "setup the result"
  @spec set_result(operation, result) :: operation
  def set_result(operation, result) when is_integer(result),
    do: %{operation | result: result}

  @doc "setup the function that will calculate the result from both terms"
  @spec set_calc_operator(operation, calc_operator) :: operation
  def set_calc_operator(operation, calc_operator) when is_function(calc_operator),
    do: %{operation | calc_operator: calc_operator}
end



