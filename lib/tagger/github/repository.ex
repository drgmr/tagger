defmodule Tagger.Github.Repository do
  @moduledoc """
  Represents a Repository on GitHub
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias Tagger.Categorization

  import Ecto.Changeset

  @default_language "Unknown"
  @default_tags ["personal-project", "documentation"]

  @required_fields [:id, :name, :description, :url]
  @fields [:recommended_tags, :language | @required_fields]

  @primary_key false
  embedded_schema do
    field :id, :string
    field :description, :string
    field :language, :string
    field :recommended_tags, {:array, :string}
    field :name, :string
    field :url, :string

    timestamps()
  end

  def changeset(repository \\ %__MODULE__{}, attrs) do
    repository
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> apply_recomendation_normalization()
    |> put_default_language()
    |> put_default_tags()
  end

  defp apply_recomendation_normalization(%Changeset{valid?: true} = changeset) do
    recommendations =
      changeset
      |> get_field(:recommended_tags)
      |> Enum.map(&Categorization.normalize_tag_name/1)

    put_change(changeset, :recommended_tags, recommendations)
  end

  defp apply_recomendation_normalization(changeset), do: changeset

  defp put_default_language(%Changeset{valid?: true} = changeset) do
    case get_field(changeset, :language) do
      nil ->
        put_change(changeset, :language, @default_language)

      _ ->
        changeset
    end
  end

  defp put_default_language(changeset), do: changeset

  defp put_default_tags(%Changeset{valid?: true} = changeset) do
    case get_field(changeset, :recommended_tags) do
      nil ->
        put_change(changeset, :recommended_tags, @default_tags)

      _ ->
        changeset
    end
  end

  defp put_default_tags(changeset), do: changeset
end
