defmodule TaggerWeb.TagViewTest do
  use TaggerWeb.ConnCase, async: true

  alias TaggerWeb.TagView

  import Phoenix.View

  describe "create.json" do
    test "renders multiple created tags" do
      first_tag = build(:tag)
      second_tag = build(:tag)

      tags = [first_tag, second_tag]

      assert results = render(TagView, "create.json", %{tags: tags})

      assert Enum.count(results) == 2

      names = Enum.map(tags, & &1.name)

      assert first_tag.name in names
      assert second_tag.name in names
    end
  end

  describe "show.json" do
    test "renders a single tag" do
      tag = build(:tag)

      assert result = render(TagView, "show.json", %{tag: tag})

      assert result == tag.name
    end
  end
end
