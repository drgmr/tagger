defmodule Tagger.SourceControl.Repository do
  @moduledoc """
  Represents a repository in a external Source Control service.
  """

  use Ecto.Schema

  import Ecto.Changeset

  @required_fields [:id, :name, :description, :url, :languages]
  @fields @required_fields

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "repositories" do
    field :description, :string
    field :languages, {:array, :string}
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
