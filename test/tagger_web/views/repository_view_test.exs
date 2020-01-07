defmodule TaggerWeb.RepositoryViewTest do
  use TaggerWeb.ConnCase, async: true

  alias TaggerWeb.RepositoryView

  import Phoenix.View

  describe "index.json" do
    test "renders multiple repositories" do
      first_repository = build(:repository_with_tags)
      second_repository = build(:repository_with_tags)

      repositories = [first_repository, second_repository]

      assert results = render(RepositoryView, "index.json", %{repositories: repositories})

      assert Enum.count(results) == 2

      ids = Enum.map(results, & &1.id)

      assert first_repository.id in ids
      assert second_repository.id in ids
    end
  end

  describe "show.json" do
    test "renders a repository with all fields" do
      repository = build(:repository_with_tags)

      assert result = render(RepositoryView, "show.json", %{repository: repository})

      for field <- [:id, :name, :url, :description, :languages] do
        assert Map.get(result, field) == Map.get(repository, field)
      end

      assert result.tags == Enum.map(repository.tags, & &1.name)
    end
  end
end
