defmodule Tagger.SourceControl do
  @moduledoc """
  Provides utilities to manage and create local data about Repositories.
  """

  alias Tagger.Repo
  alias Tagger.SourceControl.Repository

  def process_repositories(repositories),
    do: Enum.reduce_while(repositories, [], &process_repository/2)

  def process_repository(repository_data, list) do
    case upsert_repository(repository_data) do
      {:ok, repository} ->
        {:cont, [repository | list]}

      {:error, _reason} = result ->
        {:halt, result}
    end
  end

  defp upsert_repository(%{"id" => id} = repository_data) do
    case find_repository(id) do
      {:error, :not_found} -> %Repository{id: id}
      {:ok, repository} -> repository
    end
    |> Repository.changeset(repository_data)
    |> Repo.insert_or_update()
  end

  defp upsert_repository(_),
    do: {:error, :missing_id}

  defp find_repository(id) do
    case Repo.get(Repository, id) do
      nil -> {:error, :not_found}
      repository -> {:ok, repository}
    end
  end
end
