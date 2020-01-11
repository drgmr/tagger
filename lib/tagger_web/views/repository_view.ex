defmodule TaggerWeb.RepositoryView do
  use TaggerWeb, :view

  alias TaggerWeb.TagView

  def render("index.json", %{repositories: repositories}) do
    render_many(repositories, __MODULE__, "show.json")
  end

  def render("show.json", %{repository: repository}) do
    repository
    |> Map.take([
      :id,
      :name,
      :description,
      :language,
      :recommended_tags,
      :url
    ])
    |> Map.put(
      :tags,
      render_many(repository.tags, TagView, "show.json")
    )
  end
end
