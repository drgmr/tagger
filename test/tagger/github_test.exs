defmodule Tagger.GithubTest do
  use ExUnit.Case

  alias Tagger.Github

  import Tesla.Mock

  @expected_language "Swift"

  @example_repository %{
    "description" => "Another Repo",
    "id" => "ANOTHER_ID",
    "languages" => %{"nodes" => [%{"name" => @expected_language}]},
    "name" => "CoolLib",
    "url" => "https://github.com/another_user/cool_lib"
  }

  @sample_response %{
    "data" => %{
      "user" => %{
        "starredRepositories" => %{
          "nodes" => [@example_repository]
        }
      }
    }
  }

  @username "drgmr"

  describe "get_starred_repositories/1" do
    test "it returns a list of repositories with the expected format" do
      mock(fn %{method: :post, body: body} ->
        assert body =~ @username

        json(@sample_response)
      end)

      assert {:ok, repositories} = Github.get_starred_repositories(@username)

      assert [repository] = repositories

      for field <- ["id", "name", "url", "description"] do
        assert repository[field] == @example_repository[field]
      end

      assert repository["languages"] == [@expected_language]
    end
  end
end
