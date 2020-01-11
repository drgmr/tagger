defmodule Tagger.Github.Mapper do
  @moduledoc """
  Utilities to map Github's representation of a repository
  in specific API calls into our internal one.
  """

  alias Tagger.Github.Repository

  def to_repository_listing(response) do
    response
    |> Map.get("data")
    |> get_nodes()
    |> Enum.map(&to_repository_params/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.reduce_while({:ok, []}, &cast_to_repository/2)
  end

  defp get_nodes(%{"user" => user}) do
    user
    |> Map.get("starredRepositories")
    |> Map.get("nodes")
  end

  defp get_nodes(%{"nodes" => nodes}), do: nodes

  defp to_repository_params(nil), do: nil

  defp to_repository_params(data) do
    base_map = Map.take(data, ["id", "name", "url", "description"])

    primary_language = get_in(data, ["primaryLanguage", "name"])

    languages =
      data
      |> get_in(["languages", "nodes"])
      |> Enum.map(&Map.get(&1, "name"))

    base_map
    |> Map.put("recommended_tags", languages)
    |> Map.put("language", primary_language)
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
