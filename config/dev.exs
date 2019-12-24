use Mix.Config

config :tagger, Tagger.Repo,
  username: "postgres",
  password: "postgres",
  database: "tagger_dev",
  hostname: "tagger-db",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :tagger, TaggerWeb.Endpoint,
  http: [port: 4000],
  code_reloader: true,
  check_origin: false

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
