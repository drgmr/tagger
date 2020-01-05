defmodule Tagger.Categorization.TagTest do
  use Tagger.DataCase

  alias Tagger.Categorization.Tag

  @normalized_name "operating-system"

  @repository_id "MDEwOlJlcG9zaXRvcnkxNTQ4ODQ2MjI="

  @irregular_attributes %{
    "name" => "Operating System",
    "repository_id" => @repository_id
  }

  @valid_attributes %{
    "name" => @normalized_name,
    "repository_id" => @repository_id
  }

  describe "changeset/2" do
    test "fails if the required fields are not present" do
      target = %Tag{}

      assert changeset = Tag.changeset(target, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
        name: ["can't be blank"],
        repository_id: ["can't be blank"]
      }
    end

    test "creates a new changeset when provided valid data" do
      target = %Tag{}

      assert changeset = Tag.changeset(target, @valid_attributes)

      assert changeset.valid?
    end

    test "normalizes the tag name" do
      target = %Tag{}

      assert changeset = Tag.changeset(target, @irregular_attributes)

      assert changeset.valid?

      assert changeset.changes.name == @normalized_name
      assert changeset.changes.repository_id == @repository_id
    end
  end
end
