defmodule Tagger.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Tagger.Repo,
      TaggerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Tagger.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    TaggerWeb.Endpoint.config_change(changed, removed)

    :ok
  end
end
