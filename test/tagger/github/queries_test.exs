defmodule Tagger.Github.QueriesTest do
  use Tagger.DataCase

  alias Tagger.Github.Queries

  @username "drgmr"

  describe "starred_repositories/1" do
    test "it includes the username on the query data" do
      %{query: query, variables: variables} = Queries.starred_repositories(@username)

      assert query =~ "$username"
      assert variables.username == @username
    end
  end
end
