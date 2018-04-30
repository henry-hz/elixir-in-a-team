defmodule P3 do
  @moduledoc """
  Find the K'th element of a list.
  The first element in the list is number 1.
  Example:
  ?- element_at(X,[a,b,c,d,e],3).
  X = c
  """

  @doc "using pre-defined function [work with negative indexes also]"
  def element_at(list, index), do: Enum.at(list, index)

  @doc "using recursion [only with positive indexes]"
  def element_at1([], _), do: []
  def element_at1([h|_], 0), do: h
  def element_at1([h|t], index), do:
    element_at(t, index - 1)


end
