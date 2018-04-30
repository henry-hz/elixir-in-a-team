defmodule P1 do
  @moduledoc """
  Find the last element of a list.
  Example:
    my_last(x,[a,b,c,d]).
    x = d
  """

  @doc "pre-defined function"
  def find_last1(list), do: List.last(list)

  @doc "using recursion"
  def find_last2([]), do: []
  def find_last2([e]), do: e
  def find_last2([_|t]),  do: find_last2(t)

  @doc "using pipe"
  def find_last3(list), do:
    list
      |> Enum.reverse
      |> List.first

  @doc "function composition"
  def find_last4(list),
    do: find_last_fun().(list)

  def find_last_fun(), do:
    fn list ->
      list |> Enum.reverse |> List.first
    end

  @doc "using index"
  def find_last5(list), do:
    list
      |> Enum.reverse
      |> Enum.at(0)

  @doc "using fold left"
  def find_last6(list), do:
    list
    |> List.foldl(0, fn(x, _) -> x end)

end

