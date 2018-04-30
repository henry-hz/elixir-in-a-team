defmodule P2 do
  @moduledoc """
  Find the last element of a list.
  Example:
    my_last(x,[a,b,c,d]).
    x = c
  """

  @doc "using recursion"
  def find_last_but_one([]), do: []
  def find_last_but_one([e, _]), do: e
  def find_last_but_one([_|t]),  do: find_last_but_one(t)


  @doc "using pipes [drop the last, and get the last]"
  def find_last_but_one1(list), do:
    list
      |> Enum.drop(-1)
      |> List.last


  @doc "using pipes and index"
  def find_last_but_one2(list), do:
    list
      |> Enum.reverse
      |> Enum.at(1)


end

