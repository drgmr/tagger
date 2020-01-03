defmodule Tagger.Github.Queries do
  @moduledoc """
  A collection of GraphQL Queries to be run against the Github API.
  """

  @starred_repositories_query """
    query($username: String!) {
      user(login: $username) {
        starredRepositories(first: 100) {
          nodes {
            id
            name
            description
            url
            languages(first: 10) {
              nodes {
                name
              }
            }
          }
        }
      }
    }
  """

  def starred_repositories(username) do
    %{
      query: @starred_repositories_query,
      variables: %{username: username}
    }
  end
end
