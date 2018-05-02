defmodule P4 do
  @moduledoc """
  Find the number of elements of a list.
  """

  @doc "pre-defined function"
  def count(list), do: Enum.count(list)



  @doc "using recursion"
  def count1([]), do: 0
  def count1([_|t]), do: 1 + count(t)



end

