Specs
=====


## Basics

Elixir comes with a notation for declaring types, as you can see some examples
below:

- integer()
- float()
- list(type)
- binary()
- String.t

Let's make the most simple example to show how comfortable is when we use the
right names, specs and docs. 

What do you prefer? this:

```elixir
defmodule Calc do
  @moduledoc """
  Calculator module.
  """

  @typedoc "the term that will receive an addition"
  @type term1 :: integer | float

  @typedoc "the term that will be added over the first term"
  @type term2 :: integer | float

  @typedoc "result from the both terms addition"
  @type result :: integer | float

  @doc """
  Add two elemets, i.e. terms, one over another.

  ## Examples

      iex> Calc.add(1, 1)
      3

  """
  @spec add(term1, term2) :: result
  def add(term1, term2) do
    term1 + term2
  end
end
```


or this:

```elixir
defmodule ModuleM1 do

  def fun(x, y) do
    y + x
  end

end
```

We could say that the first example coulbe be called an over explanation, but
imaging the module is making a business transaction, and we had no previous
information about the terms, how to use it, what kind of result the function
output 



## Advanced

* [official-documentation](https://hexdocs.pm/elixir/typespecs.html) - original
    elixir docs
