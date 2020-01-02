defmodule Tagger.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string
      add :description, :string
      add :url, :string
      add :language, :string

      timestamps()
    end
  end
end
