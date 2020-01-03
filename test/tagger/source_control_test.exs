defmodule Tagger.SourceControlTest do
  use Tagger.DataCase

  alias Tagger.{
    SourceControl,
    SourceControl.Repository
  }

  @new_repository_data [
    id: "NEW_REPO",
    name: "New Repo",
    url: "https://github.com/some_user/new-repo",
    description: "A brand new repo!",
    languages: ["Kotlin"]
  ]

  @existing_repository_data [
    id: "EXISTING_REPO",
    name: "Existing Repo",
    url: "https://github.com/some_user/existing-repo",
    description: "It's that Repo again.",
    languages: ["Dockerfile", "Elixir"]
  ]

  @updated_repository_data [
    id: "EXISTING_REPO",
    name: "Existing Repo",
    url: "https://github.com/some_user/existing-repo",
    description: "It's that Repo again. Again.",
    languages: ["Dockerfile", "Elixir", "Elm"]
  ]

  @invalid_repository_data [
    something: "else"
  ]

  defp to_string_map(map) do
    map
    |> Enum.map(fn {key, value} -> {Atom.to_string(key), value} end)
    |> Enum.into(%{})
  end

  defp build_data(repositories_data),
    do: Enum.map(repositories_data, &to_string_map/1)

  describe "process_repositories/1" do
    test "it stores repositories never seen before" do
      insert(:repository, @existing_repository_data)

      data = build_data([@new_repository_data, @existing_repository_data])

      assert results = SourceControl.process_repositories(data)

      assert Enum.count(results) == 2

      assert existing_repository = Repo.get!(Repository, @existing_repository_data[:id])
      assert new_repository = Repo.get!(Repository, @new_repository_data[:id])

      for {key, value} <- @existing_repository_data do
        assert Map.get(existing_repository, key) == value
      end

      for {key, value} <- @new_repository_data do
        assert Map.get(new_repository, key) == value
      end
    end

    test "it updates repositories if their data has changed" do
      insert(:repository, @existing_repository_data)

      data = build_data([@updated_repository_data])

      assert results = SourceControl.process_repositories(data)

      assert Enum.count(results) == 1

      assert stored_repository = Repo.get!(Repository, @existing_repository_data[:id])

      assert stored_repository.description != @existing_repository_data[:description]
      assert stored_repository.description == @updated_repository_data[:description]
    end

    test "it stops on the first update failure" do
      data = build_data([@invalid_repository_data, @new_repository_data])

      assert {:error, _reason} = SourceControl.process_repositories(data)
    end
  end
end
