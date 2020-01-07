defmodule Tagger.Categorization do
  @moduledoc """
  Manages Tag collections related to external repositories.
  """

  alias Tagger.Repo
  alias Tagger.Categorization.Tag

  def store_categorization(repository_id, tags_params) do
    Repo.transaction(fn ->
      tags_params
      |> Enum.map(&cast_to_tag(&1, repository_id))
      |> Enum.map(&Repo.insert/1)
      |> Enum.map(fn
        {:ok, item} -> item
        {:error, reason} -> Repo.rollback(reason)
      end)
    end)
  end

  defp cast_to_tag(tag_params, repository_id) do
    tag_params
    |> Map.put("repository_id", repository_id)
    |> Tag.changeset()
  end

  def find_matching(partial_name) do
    import Ecto.Query

    query =
      from tag in Tag,
        where: ilike(tag.name, ^"#{partial_name}%")

    Repo.all(query)
  end

  def evaluate_repositories(repositories),
    do: Enum.map(repositories, &evaluate_repository/1)

  defp evaluate_repository(repository) do
    tags = find_all_tags(repository.id)

    Map.put(repository, :tags, tags)
  end

  # defp recommendations_for_repository(repository), do: nil

  defp find_all_tags(repository_id) do
    import Ecto.Query

    query =
      from tag in Tag,
        where: tag.repository_id == ^repository_id

    Repo.all(query)
  end
end
