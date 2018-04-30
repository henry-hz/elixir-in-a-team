defmodule P3 do
  @moduledoc """
  Find the K'th element of a list.
  The first element in the list is number 1.
  Example:
  ?- element_at(X,[a,b,c,d,e],3).
  X = c
  """

  def element_at([], _), do: []
  def element_at([h|_], 0), do: h
  def element_at([h|t], index), do:
    element_at(t, index - 1)


end
