defmodule P5 do
  @moduledoc """
  Reverse a list
  """


  @doc "pre-defined function"
  def reverse(list), do: Enum.reverse(list)


  @doc "using recursion"
  def reverse1([]), do: []
  def reverse1([h|t]), do: reverse(t) ++ [h]



end
