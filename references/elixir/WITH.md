


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
