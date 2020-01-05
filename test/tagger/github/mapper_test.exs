defmodule Tagger.Github.MapperTest do
  use ExUnit.Case

  import Tagger.Factory

  alias Tagger.Github.Mapper

  describe "into_repository_listing/1" do
    test "it retrieves data from the correct structure" do
      example_response = build(:example_response)
      expected_result = build(:example_repository)

      assert {:ok, [result]} = Mapper.to_repository_listing(example_response)

      assert result == expected_result
    end
  end
end
