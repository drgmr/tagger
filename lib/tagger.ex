defmodule Tagger do
  @moduledoc """
  Tagger is a small application that tracks tags for GitHub repositories.
  """

  alias Tagger.{Categorization, Github}

  def get_starred_repositories(username) do
    with {:ok, repositories} <- Github.get_starred_repositories(username) do
      repositories = Categorization.evaluate_repositories(repositories)

      {:ok, repositories}
    end
  end

  def get_repositories_by_tag(partial_name) do
    tags = Categorization.find_matching(partial_name)
    repositories_ids = Enum.map(tags, & &1.repository_id)

    with {:ok, repositories} <- Github.get_repositories_by_id(repositories_ids) do
      repositories = Categorization.evaluate_repositories(repositories)

      {:ok, repositories}
    end
  end

  defdelegate store_categorization(repository_id, name), to: Categorization
end
