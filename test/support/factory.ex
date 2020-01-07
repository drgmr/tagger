defmodule Tagger.Factory do
  @moduledoc false

  use ExMachina.Ecto,
    repo: Tagger.Repo

  alias Tagger.{Categorization.Tag, Github.Repository}

  def tag_factory do
    %Tag{
      name: sequence(:tag_name, &"tag-#{&1}"),
      repository_id: sequence(:repository_id, &"repository-#{&1}")
    }
  end

  def example_stars_response_factory do
    %{
      "data" => %{
        "user" => %{
          "starredRepositories" => %{
            "nodes" => [
              %{
                "id" => "SOME_ID",
                "name" => "SomeRepo",
                "url" => "https://github.com/some_user/SomeRepo",
                "description" => "It's a cool Repo.",
                "languages" => %{
                  "nodes" => [
                    %{
                      "name" => "Purescript"
                    }
                  ]
                }
              }
            ]
          }
        }
      }
    }
  end

  def example_search_response_factory do
    %{
      "data" => %{
        "nodes" => [
          %{
            "id" => "SOME_ID",
            "name" => "SomeRepo",
            "description" => "It's a cool Repo.",
            "url" => "https://github.com/some_user/SomeRepo",
            "languages" => %{
              "nodes" => [
                %{
                  "name" => "Purescript"
                }
              ]
            }
          },
          %{
            "id" => "ANOTHER_ID",
            "name" => "another-repo",
            "description" => "More Repos.",
            "url" => "https://github.com/some_user/another-repo",
            "languages" => %{
              "nodes" => [
                %{
                  "name" => "Elixir"
                }
              ]
            }
          },
          nil
        ]
      },
      "errors" => [
        %{
          "type" => "NOT_FOUND",
          "path" => [
            "nodes",
            2
          ],
          "locations" => [
            %{
              "line" => 2,
              "column" => 3
            }
          ],
          "message" => "Could not resolve to a node with the global id of 'UNKNOWN_REPO'"
        }
      ]
    }
  end

  def example_repository_factory do
    %Repository{
      id: "SOME_ID",
      name: "SomeRepo",
      url: "https://github.com/some_user/SomeRepo",
      description: "It's a cool Repo.",
      languages: ["Purescript"]
    }
  end

  def repository_with_tags_factory do
    repository_id = "ANOTHER_ID"

    tags = [
      build(:tag, repository_id: repository_id),
      build(:tag, repository_id: repository_id)
    ]

    %{
      id: "ANOTHER_ID",
      name: "another-repo",
      url: "https://github.com/some_user/another-another",
      description: "More Repos.",
      languages: ["Elixir"],
      tags: tags
    }
  end
end
