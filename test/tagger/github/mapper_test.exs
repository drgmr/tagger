defmodule Tagger.Github.MapperTest do
  use ExUnit.Case

  alias Tagger.Github.Mapper

  @expected_result %{
    "id" => "SOME_ID",
    "name" => "Some Repo",
    "url" => "https://github.com/some_user/some-repo",
    "description" => "It's a cool Repo.",
    "language" => "Purescript"
  }

  @languages_data %{
    "nodes" => [
      %{
        "name" => "Purescript"
      }
    ]
  }

  @example_response %{
    "data" => %{
      "user" => %{
        "starredRepositories" => %{
          "nodes" => [
            @expected_result
            |> Map.drop(["language"])
            |> Map.put("languages", @languages_data)
          ]
        }
      }
    }
  }

  describe "into_repository_listing/1" do
    test "it retrieves data from the correct structure" do
      assert [result] = Mapper.to_repository_listing(@example_response)

      for field <- ["id", "name", "url", "description", "language"] do
        assert result[field] == @expected_result[field]
      end
    end
  end
end
