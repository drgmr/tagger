defmodule TaggerWeb.TagView do
  use TaggerWeb, :view

  def render("create.json", %{tags: tags}) do
    render_many(tags, __MODULE__, "show.json")
  end

  def render("show.json", %{tag: tag}), do: tag.name
end
