defmodule TaggerWeb.RepositoryControllerTest do
  use TaggerWeb.ConnCase

  import Tesla.Mock

  @language_name "Rust"

  @expected_result %{
    "id" => "OTHER_ID",
    "name" => "Other Repo",
    "url" => "https://github.com/some_user/other-repo",
    "description" => "Another a cool Repo.",
    "language" => @language_name,
    "recommended_tags" =>  ["rust"]
  }

  @languages_data %{
    "nodes" => [
      %{
        "name" => @language_name
      }
    ]
  }

  @example_stars_response %{
    "data" => %{
      "user" => %{
        "starredRepositories" => %{
          "nodes" => [
            @expected_result
            |> Map.drop(["recommended_tags"])
            |> Map.put("languages", @languages_data)
            |> Map.drop(["language"])
            |> Map.put("primaryLanguage", %{"name" => @language_name})
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

        json(@example_stars_response)
      end)

      path = Routes.repository_path(conn, :index, %{"username" => @username})

      conn = get(conn, path)

      assert [response] = json_response(conn, :ok)

      for field <- ["id", "name", "url", "description", "languages"] do
        assert response[field] == @expected_result[field]
      end
    end

    @search_query "something"

    test "it supports searching for known repositories by tag", %{conn: conn} do
      mock(fn %{method: :post, body: body} ->
        assert body =~ "ids"

        :example_search_response
        |> build()
        |> json()
      end)

      insert(:tag, name: "something", repository_id: "SOME_ID")
      insert(:tag, name: "something-else", repository_id: "ANOTHER_ID")

      path = Routes.repository_path(conn, :index, %{"filter" => @search_query})

      conn = get(conn, path)

      assert response = json_response(conn, :ok)

      assert Enum.count(response) == 2
    end
  end
end
