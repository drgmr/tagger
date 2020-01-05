defmodule Tagger.Categorization do
  @moduledoc """
  Manages Tag collections related to external repositories.
  """

  # def store_categorization(repository_id, tags), do: nil

  # def find_matching_categorizations(partial_name), do: nil

  def evaluate_repositories(repositories),
    do: Enum.reduce_while(repositories, {:ok, []}, &evaluate_repository/2)

  defp evaluate_repository(repository, {:ok, list}) do
    case find_all_tags(repository.id) do
      {:ok, tags} ->
        item = Map.put(repository, :tags, tags)

        {:cont, {:ok, [item | list]}}

      {:error, _reason} = result ->
        {:halt, result}
    end
  end

  # defp recommendations_for_repository(repository), do: nil

  defp find_all_tags(_repository_id), do: {:ok, []}
end
