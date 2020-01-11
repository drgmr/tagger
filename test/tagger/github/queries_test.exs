defmodule Tagger.Github.QueriesTest do
  use Tagger.DataCase

  alias Tagger.Github.Queries

  describe "starred_repositories/1" do
    @username "drgmr"

    test "it includes the username on the query data" do
      %{query: query, variables: variables} = Queries.starred_repositories(@username)

      assert query =~ "$username"
      assert variables.username == @username
    end
  end

  describe "repositories_by_id/1" do
    @ids ["FIRST", "SECOND"]

    test "it includes the ids on the query data" do
      %{query: query, variables: variables} = Queries.repositories_by_id(@ids)

      assert query =~ "$ids"
      assert variables.ids == @ids
    end
  end
end
