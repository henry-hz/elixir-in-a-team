defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @typedoc "the term that will receive an addition"
  @type term1 :: integer | float

  @typedoc "the term that will be added over the first term"
  @type term2 :: integer | float

  @typedoc "result is the addition"
  @type result :: integer | float


  @typedoc "function that will in fact calculate between two terms"
  @type calc_operator :: fun()




  @doc """
  Add two elemets, i.e. terms, one over another.

  ## Examples

      iex> Calc.add(1, 1)
      3

  """
  @spec add(term1, term2) :: result
  def add(term1, term2) do
    term1 + term2
  end


  def calculate(term1, term2, calc_operator) do
    %Operation{}
      |> Operation.set_name("jim")
      |> Operation.set_calc_operator(calc_operator)
      |> Operation.set_term1(term1)
      |> Operation.set_term2(term2)
      |> Operation.execute

  end

end
