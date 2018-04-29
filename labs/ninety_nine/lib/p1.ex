defmodule P1 do
  @defmodule """
  Find the last element of a list.
  """



  @doc "pre-defined function"
  def find_last1(list), do: List.last(list)


  @doc "using recursion"
  def find_last2([l]), do: l
  def find_last2([h|t]),  do: find_last2(t)

  @doc "using pipe"
  def find_last3(list), do:
    list
      |> Enum.reverse
      |> List.first

  @doc "function composition"
  def find_last4(list),
    do: find_last_fun().(list)

  def find_last_fun(), do:
    fn list -> list |> Enum.reverse |> List.first end


  # end
  # def mul(a,b), do: a * b
  # def mul2(a), do: mul(2,a)



end

