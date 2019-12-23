defmodule TaggerWeb.Router do
  use TaggerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaggerWeb do
    pipe_through :api
  end
end
