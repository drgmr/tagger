defmodule Tagger.GithubTest do
  use Tagger.DataCase

  alias Tagger.Github

  import Tesla.Mock

  describe "get_starred_repositories/1" do
    @username "drgmr"

    test "it returns a list of repositories with the expected format" do
      mock(fn %{method: :post, body: body} ->
        assert body =~ @username

        :example_stars_response
        |> build()
        |> json()
      end)

      expected_result = build(:example_repository)

      assert {:ok, [repository]} = Github.get_starred_repositories(@username)

      assert repository == expected_result
    end
  end

  describe "get_repositories_by_id/1" do
    @invalid_id "UNKNOWN_REPO"
    @ids ["FIRST_REPO", "SECOND_REPO", @invalid_id]

    test "it returns a list of found repositories, ignoring inexistant ones" do
      mock(fn %{method: :post, body: body} ->
        for id <- @ids do
          assert body =~ id
        end

        :example_search_response
        |> build()
        |> json()
      end)

      assert {:ok, repositories} = Github.get_repositories_by_id(@ids)

      assert Enum.count(repositories) == 2

      refute @invalid_id in Enum.map(repositories, & &1.id)
    end
  end
end
