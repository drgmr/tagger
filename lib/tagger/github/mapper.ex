defmodule Tagger.Github.Mapper do
  @moduledoc """
  Utilities to map Github's representation of a repository
  in specific API calls into our internal one.
  """

  alias Tagger.Github.Repository

  def to_repository_listing(starred_repositories_response) do
    starred_repositories_response
    |> Map.get("data")
    |> Map.get("user")
    |> Map.get("starredRepositories")
    |> Map.get("nodes")
    |> Enum.map(&to_repository_params/1)
    |> Enum.reduce_while({:ok, []}, &cast_to_repository/2)
  end

  defp to_repository_params(data) do
    base_map = Map.take(data, ["id", "name", "url", "description"])

    languages =
      data
      |> get_in(["languages", "nodes"])
      |> Enum.map(&Map.get(&1, "name"))

    Map.put(base_map, "languages", languages)
  end

  defp cast_to_repository(params, {:ok, list}) do
    params
    |> Repository.changeset()
    |> Ecto.Changeset.apply_action(:insert)
    |> case do
      {:ok, repository} ->
        {:cont, {:ok, [repository | list]}}

      {:error, _changeset} = result ->
        {:halt, result}
    end
  end
end
