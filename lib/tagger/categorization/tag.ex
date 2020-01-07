defmodule Tagger.Categorization.Tag do
  @moduledoc """
  Represents a Tag associated with an exeternal repository by it's ID.
  """

  use Ecto.Schema

  alias Ecto.Changeset

  import Ecto.Changeset

  @whitespace_matcher ~r/\s+/
  @whitespace_replacement "-"

  @required_fields [:name, :repository_id]
  @fields @required_fields

  @primary_key false
  schema "tags" do
    field :name, :string, primary_key: true
    field :repository_id, :string, primary_key: true

    timestamps()
  end

  def changeset(tag \\ %__MODULE__{}, changes) do
    tag
    |> cast(changes, @fields)
    |> validate_required(@required_fields)
    |> apply_name_normalization()
    |> unique_constraint(:name, name: :tags_pkey)
  end

  defp apply_name_normalization(%Changeset{valid?: true} = changeset) do
    case get_change(changeset, :name) do
      nil -> changeset
      name -> put_change(changeset, :name, normalize_name(name))
    end
  end

  defp apply_name_normalization(changeset), do: changeset

  defp normalize_name(name) do
    name
    |> String.downcase()
    |> String.trim()
    |> String.replace(@whitespace_matcher, @whitespace_replacement)
  end
end
