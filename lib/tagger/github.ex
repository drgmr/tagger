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
    with query_params = Queries.starred_repositories(username),
         {:ok, response} <- Client.execute(query_params),
         {:ok, result} <- Mapper.to_repository_listing(response.body) do
      {:ok, result}
    end
  end

  def get_repositories_by_id(ids) do
    with query_params = Queries.repositories_by_id(ids),
         {:ok, response} <- Client.execute(query_params),
         {:ok, result} <- Mapper.to_repository_listing(response.body) do
      {:ok, result}
    end
  end
end
