defmodule TaggerWeb.RepositoryView do
  use TaggerWeb, :view

  def render("index.json", %{repositories: repositories}) do
    render_many(repositories, __MODULE__, "show.json")
  end

  def render("show.json", %{repository: repository}) do
    Map.take(
      repository,
      [
        :id,
        :name,
        :description,
        :languages,
        :url
      ]
    )
  end
end
