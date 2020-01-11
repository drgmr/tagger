defmodule Tagger.Github.Client do
  @moduledoc """
  A web client used to run GraphQL queries against Github's API.
  """

  use Tesla,
    only: [:post],
    docs: false

  @github_base_url Application.get_env(:tagger, :github_base_url)
  @github_token Application.get_env(:tagger, :github_token)

  plug Tesla.Middleware.BaseUrl, @github_base_url
  plug Tesla.Middleware.Headers, [{"Authorization", "Bearer #{@github_token}"}]
  plug Tesla.Middleware.JSON

  plug Tesla.Middleware.Logger

  def execute(params), do: post("/graphql", params)
end
