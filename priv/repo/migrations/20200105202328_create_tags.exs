defmodule Tagger.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :name, :string, primary_key: true
      add :repository_id, :string, primary_key: true

      timestamps()
    end

    create unique_index(:tags, [:name, :repository_id], name: :name_by_repository_id)
  end
end
