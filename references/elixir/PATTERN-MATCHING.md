Pattern Matching
================



```elixir
def userselect( user ) do
    cond do
      Map.has_key?( user, :id ) ->
        sel_user = User |> Repo.get( user.id )

        case sel_user do
          nil -> { :error, "Something went wrong!" }
          _ -> { :ok, sel_user }
        end
      Map.has_key?( user, :email ) ->
        sel_user = User |> Repo.get_by( email: user.email )

        case sel_user do
          nil -> { :error, "Something went wrong!" }
          _ -> { :ok, sel_user }
        end
      Map.has_key?( user, :username ) ->
        sel_user = User |> Repo.get_by( username: user.username )

        case sel_user do
          nil -> { :error, "Something went wrong!" }
          _ -> { :ok, sel_user }
        end
      true ->
        { :error, "It's immposible to select a user using this parameter." }
    end
  end
```

after using pattern matching:


```elixir

def userselect(%{id: id}), do: User |> Repo.get(id) |> sel_user()
def userselect(%{email: email}), do: User |> Repo.get(email) |> sel_user()
def userselect(%{username: username}), do: User |> Repo.get(username) |> sel_user()
def userselect(_), do: sel_user(nil)

defp sel_user(nil), do: {:error, "Something went wrong"}
defp sel_user(user), do: {:ok, user}
```



## Advanced

*
[5-things-to-remember](https://blog.carbonfive.com/2017/10/19/pattern-matching-in-elixir-five-things-to-remember/)
- see importants concepts around pattern matching
