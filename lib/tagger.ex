defmodule Tagger do
  @moduledoc """
  Tagger is a small application that tracks tags for GitHub repositories.
  """

  alias Tagger.{Github, SourceControl}

  def get_starred_repositories(username) do
    with {:ok, repositories} <- Github.get_starred_repositories(username),
         {:ok, repositories} <- SourceControl.process_repositories(repositories) do
      {:ok, repositories}
    end
  end
end
