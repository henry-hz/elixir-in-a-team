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
end
