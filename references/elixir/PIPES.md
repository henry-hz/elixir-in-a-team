Pipes
=====



### Bang functions

Sometimes, to make your pipe flow, you can't get a {:ok, res} from a function in the pipe, so below a recipe
to make it a `bang` function:

```elixir
@spec foo(any) :: {:ok, Foo.t} | {:error, String.t}
def foo(bar), do: bar |> do_the_magic

@spec foo!(any) :: Foo.t | no_return
def foo!(bar) do
  case foo(bar) do
      {:ok, result} -> result
      {:error, _}   -> raise FooError
  end
 end
```




### Anonymous functions

```elixir
def md5(str) do
    str
    |> (fn(s) -> :erlang.md5(s) end).()
    |> Base.encode16(case: :lower)
  end
```


or alternatively:


```elixir
def md5(str) do
    str
    |> (&(:erlang.md5(&1))).()
    |> Base.encode16(case: :lower)
  end
```
