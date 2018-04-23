defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "calculates using add operation" do
    assert Calc.add(3, 3) == 6
  end
end
