defmodule Tagger.Factory do
  @moduledoc false

  use ExMachina

  alias Tagger.{Categorization.Tag, Github.Repository}

  def tag_factory do
    %Tag{
      name: sequence(:tag_name, &"tag-#{&1}"),
      repository_id: build(:repository_id)
    }
  end

  def repository_id_factory do
    Ecto.UUID.generate()
    |> Base.encode64()
  end

  def example_response_factory do
    %{
      "data" => %{
        "user" => %{
          "starredRepositories" => %{
            "nodes" => [
              %{
                "id" => "SOME_ID",
                "name" => "Some Repo",
                "url" => "https://github.com/some_user/some-repo",
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

  def example_repository_factory do
    %Repository{
      id: "SOME_ID",
      name: "Some Repo",
      url: "https://github.com/some_user/some-repo",
      description: "It's a cool Repo.",
      languages: ["Purescript"]
    }
  end
end
