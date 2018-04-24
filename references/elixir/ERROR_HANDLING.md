Error Handling
==============

## Basics

Two ways for achieving the same result. The first is to use the pipe |> and for each function catch the error and propagate it down. The error has to be always returned with the same pattern, like {:error, reason} 

```elixir
connect
  |> receive_image
  |> resize
  |> rotate
  |> save
```

If receive_image returns an error,  resize needs to handle it


```elixir
def resize({:error, _}=error), do:error
```

and to propagate it down through the pipe. So rotate needs to do the same, etc..






```elixir
defmodule Test do

  @doc """
  Inserts the given JSON into the `data` field of `file`.
  """
  def insert(file, data) do
    # Read the contents of the file
    file
    |> File.read()
    |> rewrite(file, data)
    |> to_user_message()
    |> IO.puts
  end

  defp rewrite({:ok, content}, file, data) do
    content
    |> Poison.decode()
    |> write_decoded_content(file, data)
  end
  defp rewrite({:error, reason}, _, _) do
    {:error, {:on_read, reason}}
  end

  defp write_decoded_content({:ok, decoded_content}, file, data) do
    data
    |> Poison.encode()
    |> write_encoded_data(file, decoded_content)
  end
  defp write_decoded_content({:error, :invalid}, _, _) do
    {:error, {:on_decode_invalid, ""}}
  end
  defp write_decoded_content({:error, :invalid, reason}, _, _) do
    {:error, {:on_decode, reason}}
  end

  defp write_encoded_data({:ok, encoded_data}, file, decoded_content) do
    # Prepare the updated data for insertion
    # and encode the updated data
    decoded_content
    |> Map.update("data", encoded_data, fn _ -> encoded_data end)
    |> Poison.encode()
    |> write_encoded_final_data(file)
  end
  defp write_encoded_data({:error, {:invalid, reason}}, _, _) do
    {:error, {:on_encode_data, reason}}
  end

  defp write_encoded_final_data({:ok, encoded_final_data}, file) do
    file
    |> File.write(encoded_final_data)
    |> report_on_file_write()
  end
  defp write_encoded_final_data({:error, {:invalid, reason}}, _) do
    {:error, {:on_encode_final_data, reason}}
  end

  defp report_on_file_write(:ok),
    do: :ok
  defp report_on_file_write({:error, reason}),
    do: {:error, {:on_file_write, reason}}

  defp to_user_message(:ok),
    do: "Successfully updated file!"
  defp to_user_message({:error, {source, reason}}),
    do: to_error_msg source, reason

  defp to_error_message(source, reason) do
    case source do
      :on_read ->
        "Could not read file because #{reason}!"
      :on_decode_invalid ->
        "Could not parse file to JSON!"
      :on_decode ->
        "Could not parse file to JSON because #{reason}!"
      :on_encode_data ->
        "Could not encode given JSON because #{reason}!"
      :on_encode_final_data ->
        "Could not encode updated JSON because #{reason}!"
      :on_file_write ->
        "Could not write to file because #{reason}!"
    end
  end
end
```



So if you need to write a sequence of function calls where some or all are expected to return an error, `with` would be the most appropriate tool to use.

```elixir
with {:ok, result1} <- square(a),
     {:ok, result2} <- half(result1), 
     {:ok, result3} <- triple(result2),
     {:ok, result4} <- do_even_more_stuff(result3)
do
  IO.puts “Success! the result is #{result4}”
else 
  {:error, error} -> IO.puts “Oops, something went wrong: #{error}”
end
```

Now, the cool thing about with is that when one of the assignments fails, it exits returning the value that failed the pattern match. 

Using throw and catch is good for the newbies Ruby guys only, it consumes a lot of resources and the code becomes unreadable. So avoid it.


## Advanced

* https://medium.com/elixir-magic/making-error-handling-a-breeze-with-with-operator-in-elixir-1-2-93d611a878e
* https://elixirschool.com/en/lessons/advanced/error-handling/
* https://elixir-lang.org/getting-started/try-catch-and-rescue.html
* https://dzone.com/articles/error-handling-strategies
*

