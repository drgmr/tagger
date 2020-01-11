defmodule Tagger.Github.ClientTest do
  use Tagger.DataCase

  alias Tagger.Github.Client

  import Tesla.Mock

  @github_base_url Application.get_env(:tagger, :github_base_url)
  @github_token Application.get_env(:tagger, :github_token)

  @expected_url @github_base_url <> "/graphql"

  @query_params %{query: "query { contents }", variables: nil}
  @sample_response %{"data" => %{"contents" => "result"}}

  describe "execute/1" do
    test "it includes the configured authorization token" do
      mock(fn %{method: :post, url: @expected_url, headers: headers} ->
        assert :proplists.get_value("Authorization", headers) =~ @github_token

        json(@sample_response)
      end)

      assert {:ok, result} = Client.execute(@query_params)
    end

    test "it sends the expected query format" do
      mock(fn %{method: :post, url: @expected_url, body: body} ->
        decoded_body = Jason.decode!(body)

        assert decoded_body["query"] == @query_params.query
        assert decoded_body["variables"] == @query_params.variables

        json(@sample_response)
      end)

      assert {:ok, _result} = Client.execute(@query_params)
    end

    test "it returns the response as is" do
      mock(fn %{method: :post, url: @expected_url} ->
        json(@sample_response)
      end)

      assert {:ok, result} = Client.execute(@query_params)

      assert result.body["data"]["contents"] == "result"
    end
  end
end
