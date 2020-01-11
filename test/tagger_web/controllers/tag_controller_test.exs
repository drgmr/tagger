defmodule TaggerWeb.TagControllerTest do
  use TaggerWeb.ConnCase

  describe "create/2" do
    @first_tag "something"
    @second_tag "other-thing"

    @repository_id "SOME_REPO"

    test "it creates multiple tags for a repository", %{conn: conn} do
      tags = [
        %{"name" => @first_tag},
        %{"name" => @second_tag}
      ]

      path = Routes.tag_path(conn, :create, @repository_id)

      conn = post(conn, path, %{"tags" => tags})

      assert response = json_response(conn, :ok)

      assert Enum.count(response) == 2

      assert @first_tag in response
      assert @second_tag in response
    end
  end
end
