Remaping Incoming Jsons
=======================


Sometimes you have to maintain your legacy API, but internally you would love 
to use beautiful and meaninful names. For that, an amazing solution is to add 
a small function plug in the incoming controller. Why not a complete plug in 
the router path ? because not all calls need to be remaped, and you also want 
to maintain your mapping solution in the place the incoming parameters are 
arriving, for the sake of design and also performance. Let's see the 
example below, on how to translate the JSON keys.

In your web file, where phoenix automatically create the quote to introduce
needed imports for the controller, add the translate_key function. I added 
some docs, but when doing meta-programming, we generally leave them away.

```elixir

def controller do
  quote do
    use Phoenix.Controller, namespace: BackWeb
    import Plug.Conn
    import BackWeb.Router.Helpers
    import BackWeb.Gettext
    @doc """
    Sometimes, the API call comes with a different key name on the attribute data structure.
    For example, http://my_server:4000/?lang , but on the db, the field 'language' is called
    key_lan. This functions is aimmed to translate when the data structure arrives in the
    schema file, inside contexts. To send out translations, we change in the 'view' render
    file, related to that json output. You will be happy to have all your params aligned
    with the database schema names :)

      iex> Back.Helpers.translate_key(%{a: 1, b: 2, c: 3}, :b, :z)
      %{a: 1, z: 2, c: 3}
    """
    @spec translate_key(map(), String.t(), String.t()) :: map()
    def translate_key(attrs, source_key, target_key) do
      attrs
      |> Map.put(target_key, attrs[source_key])
      |> Map.drop([source_key])
    end
    @type controller_error :: nil | {:error, Ecto.Changeset.t()}
  end
end

```

In your controller, add 

```
plug :translate
```

On the end of your controller file, add:


```elixir
def translate(%{params: params} = conn, _), do:                                                                                                                  
    %{conn | params: translate_key(params, "class", "type")}  
```

Amazing, your controller can translate all the JSON calls like
{"class":"some_data_here"} to {"type":"some_data_here"}. 

See how elegant, all the controller calls will received the transformed call, 
before they arrive in the actual controller function. 


