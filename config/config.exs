use Mix.Config

config :tagger,
  ecto_repos: [Tagger.Repo],
  generators: [binary_id: true]

config :tagger, TaggerWeb.Endpoint, render_errors: [view: TaggerWeb.ErrorView, accepts: ~w(json)]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
