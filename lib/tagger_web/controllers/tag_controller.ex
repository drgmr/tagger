defmodule TaggerWeb.TagController do
  use TaggerWeb, :controller

  action_fallback TaggerWeb.FallbackController

  def swagger_definitions do
    %{
      Tag:
        swagger_schema do
          title("Tag")
          description("A Tag related to a repository")

          properties do
            name(:string, "The Tag name", required: true)
          end

          example(%{
            name: "operating-system"
          })
        end,
      Tags:
        swagger_schema do
          title("Tag")
          description("A collection of Tags")
          type(:array)
          items(Schema.ref(:Tag))
        end
    }
  end

  swagger_path :create do
    post("/repositories/:id/tags")
    summary("Attaches a new Tag to the repository")

    description("""
    Locally stores the new tag with a reference to the given repository.

    Duplicates are not allowed and the Tag name is normalized to a lowercase, dash separated sequence of words.
    """)

    parameter(:tags, :body, Schema.ref(:Tags), "Tags to be added", required: true)
    response(200, "Success", Schema.ref(:Tags))
    response(400, "Invalid data or Tag already exists", :string)
  end

  def create(conn, %{"id" => repository_id, "tags" => tags}) do
    with {:ok, tags} <- Tagger.store_categorization(repository_id, tags) do
      conn
      |> put_status(:ok)
      |> render(%{tags: tags})
    end
  end
end
