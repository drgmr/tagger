defmodule TaggerWeb.Router do
  use TaggerWeb, :router

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Tagger",
        basePath: "/api"
      }
    }
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaggerWeb do
    pipe_through :api

    scope "/repositories" do
      resources "/", RepositoryController, only: [:index]
    end
  end
end
