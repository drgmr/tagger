defmodule Tagger.Github.RepositoryTest do
  use Tagger.DataCase

  import Ecto.Changeset

  alias Tagger.Github.Repository

  @valid_attributes %{
    "id" => "SOME_EXTERNAL_ID",
    "description" => "Some Cool Repository",
    "language" => "PureScript",
    "recommended_tags" => ["purescript", "dockerfile"],
    "name" => "some-cool-repository",
    "url" => "https://github.com/some_user/some-cool-repository"
  }

  describe "changeset/2" do
    test "fails if the required fields are not present" do
      target = %Repository{}

      assert changeset = Repository.changeset(target, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               id: ["can't be blank"],
               description: ["can't be blank"],
               name: ["can't be blank"],
               url: ["can't be blank"]
             }
    end

    test "creates a new changeset with appropriate data" do
      target = %Repository{}

      assert changeset = Repository.changeset(target, @valid_attributes)

      assert changeset.valid?
    end

    test "adds default values for some language and tag recomendations" do
      data = Map.drop(@valid_attributes, [:language, :recommended_tags])

      target = %Repository{}

      assert changeset = Repository.changeset(target, data)

      assert changeset.valid?

      assert get_field(changeset, :language) != nil
      assert get_field(changeset, :recommended_tags) != nil
      assert get_field(changeset, :recommended_tags) != []
    end
  end
end
