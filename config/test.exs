use Mix.Config

config :tagger,
  github_base_url: "https://example.com",
  github_token: "IT_IS_A_SECRET"

config :tagger, Tagger.Repo,
  username: "postgres",
  password: "postgres",
  database: "tagger_test",
  hostname: "tagger-db",
  pool: Ecto.Adapters.SQL.Sandbox

config :tesla, adapter: Tesla.Mock

config :tagger, TaggerWeb.Endpoint, server: false

config :logger, level: :warn
