# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rest,
  ecto_repos: [Rest.Repo]

# Configures the endpoint
config :rest, RestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "++3sXhT3fCSXA8C30wCaFm9j8tFfafyThiuKrA63sQbcaGyqKr14hp7aHS7xcEHo",
  render_errors: [view: RestWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Rest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
