defmodule Tagger.GithubTest do
  use ExUnit.Case

  alias Tagger.Github

  import Tesla.Mock
  import Tagger.Factory

  @username "drgmr"

  describe "get_starred_repositories/1" do
    test "it returns a list of repositories with the expected format" do
      mock(fn %{method: :post, body: body} ->
        assert body =~ @username

        :example_response
        |> build()
        |> json()
      end)

      expected_result = build(:example_repository)

      assert {:ok, [repository]} = Github.get_starred_repositories(@username)

      assert repository == expected_result
    end
  end
end
