use Mix.Config

config :tagger, Tagger.Repo,
  username: "postgres",
  password: "postgres",
  database: "tagger_test",
  hostname: "tagger-db",
  pool: Ecto.Adapters.SQL.Sandbox

config :tagger, TaggerWeb.Endpoint, server: false

config :logger, level: :warn
