defmodule Tagger.SourceControl.RepositoryTest do
  use Tagger.DataCase

  alias Tagger.SourceControl.Repository

  @valid_attributes %{
    "id" => "SOME_EXTERNAL_ID",
    "description" => "Some Cool Repository",
    "languages" => ["PureScript", "Dockerfile"],
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
               languages: ["can't be blank"],
               name: ["can't be blank"],
               url: ["can't be blank"]
             }
    end

    test "creates a new changeset with appropriate data" do
      target = %Repository{}

      assert changeset = Repository.changeset(target, @valid_attributes)

      assert changeset.valid?
    end
  end
end
