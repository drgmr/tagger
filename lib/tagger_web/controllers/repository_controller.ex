defmodule TaggerWeb.RepositoryController do
  use TaggerWeb, :controller

  action_fallback TaggerWeb.FallbackController

  def swagger_definitions do
    %{
      Repository:
        swagger_schema do
          title("Repository")
          description("A code repository")

          properties do
            id(:string, "Unique identifier", required: true)
            name(:string, "Repository name", required: true)
            description(:string, "A user-friendly description", required: true)
            url(:string, "The GitHub URL for this repository", required: true)
            languages(array(:string), "The languages used in this repository", required: true)
          end

          example(%{
            id: "676c8df5-c713-459d-bb42-20012e0570f0",
            name: "example-repository",
            description: "Some Example Repository",
            url: "https://github.com/some_user/example-repository",
            languages: ["Elixir", "JavaScript"]
          })
        end,
      Repositories:
        swagger_schema do
          title("Repositories")
          description("A collection of repositories")
          type(:array)
          items(Schema.ref(:Repository))
        end
    }
  end

  swagger_path :index do
    get("/repositories")
    summary("Lists a GitHub user's starred repositories")
    description("Using GitHub's API, lists the starred repositories of a given user.")
    parameter(:username, :query, :string, "GitHub username", required: true)
    response(200, "Repositories", :Repositories)
    tag("repository")
  end

  def index(conn, %{"username" => username}) do
    with {:ok, repositories} <- Tagger.get_starred_repositories(username) do
      conn
      |> put_status(:ok)
      |> render(%{repositories: repositories})
    end
  end
end
