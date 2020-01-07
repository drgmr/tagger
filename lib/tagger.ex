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

  defdelegate store_categorization(repository_id, name), to: Categorization
end
