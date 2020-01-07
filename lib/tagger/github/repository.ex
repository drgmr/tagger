defmodule Tagger.Github.Repository do
  @moduledoc """
  Represents a Repository on GitHub
  """

  use Ecto.Schema

  import Ecto.Changeset

  @required_fields [:id, :name, :description, :url, :languages]
  @fields @required_fields

  @primary_key false
  embedded_schema do
    field :id, :string
    field :description, :string
    field :languages, {:array, :string}
    field :name, :string
    field :url, :string

    timestamps()
  end

  def changeset(repository \\ %__MODULE__{}, attrs) do
    repository
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
