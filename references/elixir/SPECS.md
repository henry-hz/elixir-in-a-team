Specs
=====


## Basics

Elixir comes with a notation for declaring types.

- integer()
- float()
- list(type)
- binary()
- String.t

example:

```elixir
@spec add(integer(), integer()) :: integer
def add(term1, term2) do
  term1 + term2
end
```


## Advanced

* [official-documentation](https://hexdocs.pm/elixir/typespecs.html) - original
    elixir docs
