defmodule Tagger.Github do
  @moduledoc """
  Provides an interface with Github's API.
  """

  alias Tagger.Github.{
    Client,
    Mapper,
    Queries
  }

  def get_starred_repositories(username) do
    query_params = Queries.starred_repositories(username)

    with {:ok, response} <- Client.execute(query_params),
         {:ok, result} <- Mapper.to_repository_listing(response.body) do
      {:ok, result}
    end
  end

  def get_repositories_by_id(ids) do
    query_params = Queries.repositories_by_id(ids)

    with {:ok, response} <- Client.execute(query_params),
         {:ok, result} <- Mapper.to_repository_listing(response.body) do
      {:ok, result}
    end
  end
end
