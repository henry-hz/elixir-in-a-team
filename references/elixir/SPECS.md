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

Using specs, you will always know what type of data is getting into the
function, and also, what type of data will be on the output. An amazing tool
called dialyzer will make several tests automatically, to check the type
consistency and much more.

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


## Advanced

* [official-documentation](https://hexdocs.pm/elixir/typespecs.html) - original
    elixir docs
