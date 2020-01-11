defmodule Tagger.Github.MapperTest do
  use Tagger.DataCase

  alias Tagger.Github.Mapper

  describe "into_repository_listing/1" do
    test "it retrieves data from the correct structure with stars responses" do
      example_response = build(:example_stars_response)
      expected_result = build(:example_repository)

      assert {:ok, [result]} = Mapper.to_repository_listing(example_response)

      assert result == expected_result
    end

    test "it retrieves data form the correct structure with search responses" do
      example_response = build(:example_search_response)
      expected_result = build(:example_repository)

      assert {:ok, results} = Mapper.to_repository_listing(example_response)

      result = Enum.find(results, &(&1.id == expected_result.id))

      assert result == expected_result
    end

    test "it ignores empty items" do
      example_response = build(:example_search_response)

      assert {:ok, results} = Mapper.to_repository_listing(example_response)

      assert Enum.count(results) == 2
    end
  end
end
