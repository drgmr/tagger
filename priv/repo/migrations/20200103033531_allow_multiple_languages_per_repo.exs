defmodule Tagger.Repo.Migrations.AllowMultipleLanguagesPerRepo do
  use Ecto.Migration

  def change do
    alter table(:repositories) do
      remove :language, :string

      add :languages, {:array, :string}, default: []
    end
  end
end
