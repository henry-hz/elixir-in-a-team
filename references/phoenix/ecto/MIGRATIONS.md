Ecto Migrations
===============


### Creating

```
mix ecto.gen.migration update_posts_table
  creating priv/repo/migrations/20160602085927_update_posts_table.exs
  ···
$ mix ecto.migrate
$ mix ecto.rollback
```

### Creating tables

```
create table(:documents) do
  add :title, :string
  add :title, :string, size: 40
  add :title, :string, default: "Hello"
  add :title, :string, default: fragment("now()")
  add :title, :string, null: false
  add :body, :text
  add :age, :integer
  add :price, :float
  add :price, :float, precision: 10, scale: 2
  add :published_at, :datetime
  add :group_id, references(:groups)
  add :object, :json

  timestamps  # inserted_at and updated_at
end

create_if_not_exists table(:documents) do: ... end
```

### Execute SQL

```
execute "UPDATE posts SET published_at = NULL"
execute create: "posts", capped: true, size: 1024
```

### Other operations

```
alter table(:posts) do
  add :summary, :text
  modify :title, :text
  remove :views
end
rename table(:posts), :title, to: :summary
rename table(:posts), to: table(:new_posts)
drop table(:documents)
drop_if_exists table(:documents)
table(:documents)
table(:weather, prefix: :north_america)
```

### Indexes

```
create index(:posts, [:slug], concurrently: true)
create unique_index(:posts, [:slug])
drop index(:posts, [:name])
```

## Advanced

* http://devdocs.io/phoenix/ecto/ecto.migration
* https://hexdocs.pm/ecto/Ecto.Migration.html
