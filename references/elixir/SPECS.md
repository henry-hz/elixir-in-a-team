Specs
=====

Firstly, it acts as documentation. It’s much easier to read and understand code if you know what the types are. Even the best named arguments and functions can be ambiguous when you are trying to get to grips with new code. Function specifications and custom types make it explicitly clear as to what is going on, and tools like ExDoc can take advantage of your specifications to show this kind of detail in the documentation that is produced from your code.

Secondly, you can use Dialyzer, which is an Erlang static analysis tool to find discrepancies or possible bugs in your code. In Elixir we can use dialyxir to make it easier to work with Dialyzer. Whilst using Dialyzer does not guarantee that you will find all bugs and errors in your code, you are sure to get some benefit from writing specs and using a static analysis tool.



## Basics

* [intro](https://elixirschool.com/en/lessons/advanced/typespec/) good introduction on specs.
* [what-are-typespecs](https://www.culttt.com/2016/10/26/specifications-types-elixir/)
- why and how to use type and specs

Elixir comes with a notation for declaring types, as you can see some examples
below:

```
type :: any()                   # the top type, the set of all terms
      | none()                  # the bottom type, contains no terms
      | atom()
      | map()                   # any map
      | pid()                   # process identifier
      | port()
      | reference()
      | struct()                # any struct
      | tuple()                 # tuple of any size

                                ## Numbers
      | float()
      | integer()
      | neg_integer()           # ..., -3, -2, -1
      | non_neg_integer()       # 0, 1, 2, 3, ...
      | pos_integer()           # 1, 2, 3, ...

                                                    ## Lists
      | list(type)                                  # proper list ([]-terminated)
      | nonempty_list(type)                         # non-empty proper list
      | maybe_improper_list(type1, type2)           # proper or improper list
      | nonempty_improper_list(type1, type2)        # improper list
      | nonempty_maybe_improper_list(type1, type2)  # non-empty proper or improper list
```


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
