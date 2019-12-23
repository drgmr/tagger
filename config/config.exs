# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tagger,
  ecto_repos: [Tagger.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :tagger, TaggerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rd9S6hfMpVYC8mqzUF0h6HFFiIab9jSB5CXlB+XnXLb5lcZI67Qt6d8Ojv2vBsJ9",
  render_errors: [view: TaggerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Tagger.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
