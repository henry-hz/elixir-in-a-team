Ecto Multi
==========

## Basics

The module below is responsible for file creation transaction which consists of three operations:

Storing attachment by calling File.Attachment.store which basically copies the file into the proper place and returns the path.
Inserting the DB record with the path received from the previous step.
Run some processing task asynchronously passing the struct from the previous step.
You may ask why am I using Ecto.Multi when I have only one database query? Because if any of the steps returns an error it prevents the multi from executing next steps.


```elixir
defmodule MyApp.File.Create do
  alias Ecto.Multi
  alias MyApp.{Repo, File}

  def call(attachment, user) do
    case transaction(attachment, user) |> Repo.transaction do
      {:ok, %{insert: file}} -> {:ok, file}
      {:error, _, reason, _} -> {:error, reason}
    end
  end

  defp transaction(attachment, user) do
    Multi.new
    |> Multi.run(:store, fn _ -> File.Attachment.store(attachment) end)
    |> Multi.run(:insert, &insert(&1.store, user))
    |> Multi.run(:process, &process(&1.insert))
  end

  defp insert(path, user) do
    %File{}
    |> File.changeset(%{path: path, owner_id: user.id})
    |> Repo.insert
  end

  defp process(file) do
    Task.start_link(fn -> File.Process.call(file) end)
  end
end
```

Inside the create function, we’re creating a new Multi struct with Ecto.Multi.new. The important thing here is we’re creating a data type that stores a local log of every step along the way. This is the all-together-now approach to the code. 

This is a nice way to setup a changeset, adding some defaults more simply. A basic Customer changeset with whatever parameters I know about, and setting up the wallet association. A lot of power, and little fuss. Win.

Now we’re on to some custom code with run (twice, actually). We can write any function we’d like. We still label every step, we always label every step. The key is to use the right return value: {:ok,value} or {:error, value}. The more I build with Elixir, the more I love this interface. It makes it easier to manage error handling code with tuples like this.

Finally, we call transaction. This also uses the same tuple return code and the same labeling convention. (works only with Postgres)


```elixir
defmodule Bank.CustomerRegistration do
  use Bank.Model

  def create(username, email, password) do
    Ecto.Multi.new
    |> Ecto.Multi.insert(:customer, Customer.build(%{username: username, email: email}))
    |> Ecto.Multi.run(:account, fn _ ->
      Auth.register(%{email: email, password: password})
    end)
    |> Ecto.Multi.run(:update, fn %{customer: customer, account: account} ->
      Ecto.Changeset.change(customer, auth_account_id: account.id)
      |> Repo.update
    end)
    |> Repo.transaction()
  end
end

# in another module
def build(%{username: username} = params) do
  changeset(%Customer{}, params)
  |> put_assoc(:wallet, Ledger.Account.build_wallet("Wallet: #{username}"))
end

```

First, let’s tackle the entry_transaction function. The Ecto.Multi module has functions available that correspond with Ecto.Repo functions like insert, delete, and update (to name just a few). However, these accept a new second argument that is identified in the docs as name. The name argument lets you name a particular portion of the grouped transactions in order to pattern match on it later. In my example above, I’ve simply named them after the record that is being dealt with. We’ll come back to this later when we check out our enter_doorfunction. Note that these have to be unique within the transaction grouping.

Each step of the transaction passes the Multi.new result down through the chain until eventually, after building up our transaction a piece at a time, we tell our Repo to actually make the calls.

If at any point in the steps a changeset has errors or the database call itself fails for one reason or another, none of the database calls will be persisted. The particular call that fails the transaction will be returned in a tuple with the form of {:error, name_of_call, failed_value,changes_that_succeeded}. The failed_value will contain the changeset errors (if using a changeset) or any other error values the call returned. changes_that_succeeded will contain the results of any previous operations that were successful. However, as the docs state,

any successful operations would have been rolled back

because the transaction itself failed.

This is now where we can take a look at the enter_door function. If the transaction fails, we’ve already seen how it will return the {:error, ...} tuple for us to deal with how we’d like. If it succeeds, it will return a tuple with {:ok, map}. In map, we can access the success values of each of the individual operations from the value of what we named that particular operation. So in our example the :entry key in map would correspond with the result of the operation:


```elixir
defmodule Guard do
  def enter_door(person, door) do
    case entry_transaction(person, door) do
      {:ok, %{entry: entry, log: log, person: person}} ->
        Logger.debug("Success on all three!")
      {:error, :log, _failed_value, _changes_successful} ->
        Logger.debug("Failed to save Log")
      {:error, :person, _failed_value, _changes_successful} ->
        Logger.debug("Failed to save Person")
      {:error, :entry, _failed_value, _changes_successful} ->
        Logger.debug("Failed to save Entry")
    end
  end
  
  def entry_transaction(person, door) do
    Multi.new
    |> Multi.insert(:entry, Entry.changeset(%Entry{}, %{door_id: door.id, person_id: person.id}})
    |> Multi.update(:person, Person.increase_entry_count_changeset(person))
    |> Multi.insert(:log, Log.changeset(%Log{}, %{text, "entry"}))
    |> Repo.transaction()
  end
end
```



Another thing we can do with Ecto.Multi is utilize the run/3 function to execute arbitrary code within which we will have the result of any previously-run and successful operations. Let’s take a look at an example.

Pretend we want to ensure that a Person doesn’t enter a Door more than 10 times. Something like that would normally (and probably should still) be done inside a changeset for Person, but in our case, let’s utilize run/3 to check whether our Person now has more than 10 entries:

Ecto.Multi.run expects to receive a tuple containing either {:ok, message} or {:error,message} in order to determine whether to continue the transaction.

We can see above that we pattern match on the Person which has the result of successfully running the update operation above it. So if before the operation the Person had 10 entries, after the successful update, it would have 11 and trigger the failure. The error message would be passed on into the pattern-matched failure in the case statement.

```elixir
defmodule Guard do
  alias Ecto.Multi

  def enter_door(person, door) do
    case entry_transaction(person, door) do
      {:ok, %{entry: entry, log: log, person: person}} ->
        Logger.debug("Success on all four!")
      {:error, :allowed, _failed_value, _changes_successful} ->
        Logger.debug("Failed to pass allowed check")
      # ... other pattern matched failures
    end
  end
  
  def entry_transaction(person, door) do
    Multi.new
    |> Multi.insert(:entry, Entry.changeset(%Entry{}, %{door_id: door.id, person_id: person.id}})
    |> Multi.update(:person, Person.increase_entry_count_changeset(person))
    |> Mutli.run(:allowed, fn(%{person: person}) ->     # NEW CODE
      if person.entry_count > 10 do                     # 
        {:error, "Person entered more than 10 times"}   # 
      else                                              # 
        {:ok, "continue"}                               # 
      end                                               # 
    end)                                                # 
    |> Multi.insert(:log, Log.changeset(%Log{}, %{text, "entry"}))
    |> Repo.transaction()
  end
end
```




## Advanced


*Oficial Documentation*
https://hexdocs.pm/ecto/Ecto.Multi.html



*Blogs*

* http://blog.danielberkompas.com/2016/09/27/ecto-multi-services.html 
* https://hexdocs.pm/ecto/Ecto.Multi.html 
* https://medium.com/heresy-dev/a-brief-guide-to-ecto-multi-9c8ea0c729f0 
* https://blog.danielberkompas.com/2016/09/27/ecto-multi-services/
