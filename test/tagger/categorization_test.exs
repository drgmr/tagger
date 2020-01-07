defmodule Tagger.CategorizationTest do
  use Tagger.DataCase

  alias Tagger.{Categorization, Categorization.Tag}

  describe "store_categorization/2" do
    @repository_id "SOME_ID"

    @invalid_tag ""

    @first_tag "some-category"
    @second_tag "another-category"

    test "it inserts multiple valid tags" do
      tags_params = [
        %{"name" => @first_tag},
        %{"name" => @second_tag}
      ]

      assert {:ok, result_tags} = Categorization.store_categorization(@repository_id, tags_params)

      assert Enum.count(result_tags) == 2

      tags = Repo.all(Tag)

      assert Enum.count(tags) == 2

      tag_names = Enum.map(tags, & &1.name)

      assert @first_tag in tag_names
      assert @second_tag in tag_names

      assert Enum.all?(tags, &(&1.repository_id == @repository_id))
    end

    test "it fails if any given tag is invalid" do
      tag_params = [
        %{"name" => @first_tag},
        %{"name" => @invalid_tag},
        %{"name" => @second_tag}
      ]

      assert {:error, changeset} = Categorization.store_categorization(@repository_id, tag_params)

      refute changeset.valid?

      assert Tag
             |> Repo.all()
             |> Enum.count()
             |> Kernel.==(0)
    end
  end

  describe "evaluate_repositories/1" do
    @first_repository_id Ecto.UUID.generate()
    @second_repository_id Ecto.UUID.generate()
    @third_repository_id Ecto.UUID.generate()

    @first_tag "first-tag"
    @second_tag "second-tag"

    test "it adds tags to all matching repositories" do
      first_repository = build(:example_repository, id: @first_repository_id)
      second_repository = build(:example_repository, id: @second_repository_id)
      third_repository = build(:example_repository, id: @third_repository_id)

      insert(:tag, name: @first_tag, repository_id: first_repository.id)
      insert(:tag, name: @first_tag, repository_id: second_repository.id)
      insert(:tag, name: @second_tag, repository_id: second_repository.id)

      repositories = [
        first_repository,
        second_repository,
        third_repository
      ]

      assert repositories = Categorization.evaluate_repositories(repositories)

      assert Enum.count(repositories) == 3

      first_result = Enum.find(repositories, &(&1.id == @first_repository_id))
      second_result = Enum.find(repositories, &(&1.id == @second_repository_id))
      third_result = Enum.find(repositories, &(&1.id == @third_repository_id))

      assert [@first_tag] = take_names(first_result.tags)

      assert @first_tag in take_names(second_result.tags)
      assert @second_tag in take_names(second_result.tags)

      assert [] == take_names(third_result.tags)
    end
  end

  describe "find_matching/1" do
    test "it finds all matching tags" do
      first_tag = insert(:tag, name: "something")
      second_tag = insert(:tag, name: "some-other-thing")

      insert(:tag, name: "different-stuff")

      assert results = Categorization.find_matching("some")

      assert Enum.count(results) == 2

      names = take_names(results)

      assert first_tag.name in names
      assert second_tag.name in names
    end
  end

  describe "normalize_name/1" do
    @example_name "Some Tag"
    @normalized_name "some-tag"

    test "it normalizes a irregular tag name" do
      assert @normalized_name == Categorization.normalize_tag_name(@example_name)
    end
  end

  defp take_names(tags), do: Enum.map(tags, & &1.name)
end
