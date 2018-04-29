defmodule NinetyNineTest do
  use ExUnit.Case
  doctest NinetyNine

  test "greets the world" do
    assert NinetyNine.hello() == :world
  end
end
