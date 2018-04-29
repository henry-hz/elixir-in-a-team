Function Application
====================

 Especially given that the function signature of a function in Elixir includes its arity, it seems somewhat unlikely that Elixir would support currying and/or partial function application.  But a little bit of hacking turned up a nice surprise.  While Elixir may not support currying  it does support partial function application which seems to be the main reason to concern one’s self with currying anyway.


### Partial Function Application With Lambdas

```elixir
multiply = &(&1 * &2)
times_two = &(multiply.(&1, 2))
```


### Partial Function Application With Module


```elixir

defmodule PaTest do
  def multiply(n, m), do: n * m

  def times_two, do: multiply(2, m)
end




