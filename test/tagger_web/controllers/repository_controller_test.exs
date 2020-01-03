defmodule TaggerWeb.RepositoryControllerTest do
  use TaggerWeb.ConnCase

  import Tesla.Mock

  @expected_result %{
    "id" => "OTHER_ID",
    "name" => "Other Repo",
    "url" => "https://github.com/some_user/other-repo",
    "description" => "Another a cool Repo.",
    "languages" => ["Rust"]
  }

  @languages_data %{
    "nodes" => [
      %{
        "name" => "Rust"
      }
    ]
  }

  @example_response %{
    "data" => %{
      "user" => %{
        "starredRepositories" => %{
          "nodes" => [
            @expected_result
            |> Map.drop(["languages"])
            |> Map.put("languages", @languages_data)
          ]
        }
      }
    }
  }

  @username "drgmr"

  describe "index/2" do
    test "it supports browsing an user's starred directories", %{conn: conn} do
      mock(fn %{method: :post, body: body} ->
        assert body =~ @username

        json(@example_response)
      end)

      path = Routes.repository_path(conn, :index, %{"username" => @username})

      conn =
        conn
        |> get(path)
        |> save(title: "Browsing starred repositories")

      assert [response] = json_response(conn, :ok)

      for field <- ["id", "name", "url", "description", "languages"] do
        assert response[field] == @expected_result[field]
      end
    end
  end
end
