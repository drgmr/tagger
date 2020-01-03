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
    with query_params <- Queries.starred_repositories(username),
         {:ok, response} <- Client.execute(query_params) do
      result = Mapper.to_repository_listing(response.body)

      {:ok, result}
    end
  end
end
