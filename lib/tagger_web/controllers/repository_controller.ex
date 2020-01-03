defmodule TaggerWeb.RepositoryController do
  use TaggerWeb, :controller

  action_fallback TaggerWeb.FallbackController

  def index(conn, %{"username" => username}) do
    with {:ok, repositories} <- Tagger.get_starred_repositories(username) do
      conn
      |> put_status(:ok)
      |> render(%{repositories: repositories})
    end
  end
end
