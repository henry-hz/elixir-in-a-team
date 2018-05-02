defmodule P6 do
  @moduledoc """
  Find out whether a list is a palindrome. 
  """


  def is_palindrome?(list), do: list == Enum.reverse(list)


end
