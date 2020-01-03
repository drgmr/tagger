use Mix.Config

config :tagger,
  ecto_repos: [Tagger.Repo],
  generators: [binary_id: true]

config :tagger,
  github_base_url: "https://api.github.com",
  github_token: System.get_env("GITHUB_TOKEN")

config :tagger, TaggerWeb.Endpoint, render_errors: [view: TaggerWeb.ErrorView, accepts: ~w(json)]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

config :blue_bird,
  docs_path: "priv/static/docs",
  theme: "triple",
  router: TaggerWeb.Router

import_config "#{Mix.env()}.exs"
