With
====


## Basics

We start with using the with keyword and the first assignment on the first line. I wanted to make that pretty and indent it underneath with, but that’s not OK.

We are pattern matching {:ok, width} with Map.fetch(opts, :width). This uses a backwards arrow operator which is a little strange. There’s probably a good explanation about why not pattern match on an =. Whatever the reason, it helps me think about each step of my work because it’s different.

Put another way, that first line fetches :width from the opts map. It expects a tuple starting with :ok, and whatever width is in the map (10 in our case). If that doesn’t match, the else code is called. More on that in a moment.

Notice a comma at the end of the first pattern match/operation. We then go to the next operation, and keep going as long as we’d like, pattern matching and collecting values as we go. These values are available to me in subsequent calls or my do block. Did you notice that block? In this case, it returns {:ok, width * height}. If all went well, we get the area of a square. If not, the else code is written.

Now, the else statement works like a case. Something didn’t work, let’s pattern match what that was. In this case, we expect :error only, so we use :error -> {:error, :wrong_data}. If things could go wrong inconsistently, you could write many pattern matching entries here. The syntax for the else is like a case, meaning no commas and forward arrows.

with recapped:

* start the with operations on the same line as with
* use backward arrows ( < -) for the operations
* use commas to separate operations
* pattern match the happy path from each operation
* create a do block to handle what happens when everything goes write
* create an else block to handle what happens when something goes wrong
* leave the else block out if you can handle the error response directly
* use case syntax for the else block (forward arrows ( - >) and no commas)



```elixir
opts = %{width: 10}
with {:ok, width} <- Map.fetch(opts, :width),
     {:ok, height} <- Map.fetch(opts, :height) do
  {:ok, width * height}
else
  :error ->
    {:error, :wrong_data}
end
```

Below is an example that we will rewrite with more flexibility, using `with`

```elixir
defmodule User do
  defstruct name: nil, dob: nil

  def create(params) do
   %User{}
      |> parse_dob(params["dob"])
      |> parse_name(params["name"])
  end

  defp parse_dob(user, nil), do: {:error, "dob is required"}
  defp parse_dob(user, dob) when is_integer(dob), do: %{user | dob: dob}
  defp parse_dob(_user, _invalid), do: {:error "dob must be an integer"}

  defp parse_name(_user, {:error, _} = err), do: err
  defp parse_name(user, nil), do: {:error, "name is required"}
  defp parse_name(user, ""), do: parse_name(user, nil)
  defp parse_name(user, name), do: %{user | name: name}

end
```

The problem with this approach is that every function in the chain needs to handle the case where any function before it returned an error. It's clumsy, both because it isn't pretty and because it isn't flexible. Any new return type that we introduced has to be handled by all functions in the chain.

The pipe operator is great when all functions are acting on a consistent piece of data. It falls apart when we introduce variability. That's where with comes in. with is a lot like a |> except that it allows you to match each intermediary result.

Let's rewrite our code:

```elixir
defmodule User do
  defstruct name: nil, dob: nil
	def create(params) do
		with {:ok, dob} <- parse_dob(params["dob"]),
				 {:ok, name} <- parse_name(params["name"])
		do
			%User{dob: dob, name: name}
		else
			# nil -> {:error, ...} an example that we can match here too
			err -> err
		end
	end

  defp parse_dob(nil), do: {:error, "dob is required"}
  defp parse_dob(dob) when is_integer(dob), do: {:ok, dob}
  defp parse_dob(_invalid), do: {:error "dob must be an integer"}

  defp parse_name(nil), do: {:error, "name is required"}
  defp parse_name(""), do: parse_name(nil)
  defp parse_name(name), do: {:ok, name}
end
```



Instead of this:

```elixir
defp serve(socket) do
  msg =
    case read_line(socket) do
      {:ok, data} ->
        case KVServer.Command.parse(data) do
          {:ok, command} ->
            KVServer.Command.run(command)
          {:error, _} = err ->
            err
        end
      {:error, _} = err ->
        err
    end

  write_line(socket, msg)
  serve(socket)
end
```

See how beautiful is this:

```elixir
defp serve(socket) do
  msg =
    with {:ok, data} <- read_line(socket),
         {:ok, command} <- KVServer.Command.parse(data),
         do: KVServer.Command.run(command)

  write_line(socket, msg)
  serve(socket)
end
```


But because the `msg` is unexpected, we should cover all possible returns:

```elixir
defp serve(socket) do
  msg =
    with {:ok, data} <- read_line(socket),
         {:ok, command} <- KVServer.Command.parse(data),
         do: KVServer.Command.run(command)

  case msg do
    {:ok, value} -> # The whole chain succeeded
      write_line(socket, msg)

    {:error, :read_line, error} -> # Bailed out in `read_line/1`
      Log.error "Bad read_line/1 from socket #{inspect(socket)}"

    {:error, :command_parse, error} ->
      Log.error "Can't parse response #{inspect(data)}"
      do_something_with(error)

    unexpected ->
      Log.error "Got unexpected value #{inspect(unexpected)}"
  end

  serve(socket)
end
```


but from Elixir 1.3

```elixir
defp serve(socket) do
  with {:ok, data} <- read_line(socket),
       {:ok, command} <- KVServer.Command.parse(data),
       {:ok, msg} <- KVServer.Command.run(command) do
    write_line(socket, msg)
  else
    {:error, :read_line, error} -> # Bailed out in `read_line/1`
      Log.error "Bad read_line/1 from socket #{inspect(socket)}"

    {:error, :command_parse, error} -> # Bailed in ...Command.parse/1
      Log.error "Can't parse response #{inspect(data)}"
      do_something_with(error)

    unexpected ->
      Log.error "Got unexpected value #{inspect(unexpected)}"
  end

  serve(socket)
end
```





## Advanced

See our `error handling` section for more examples.

* https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html
* http://openmymind.net/Elixirs-With-Statement/
* http://relistan.com/elixir-thoughts-on-the-with-statement/
* http://learningelixir.joekain.com/learning-elixir-with/
