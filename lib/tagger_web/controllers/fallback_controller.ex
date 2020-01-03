defmodule TaggerWeb.FallbackController do
  use TaggerWeb, :controller

  def call(conn, {:error, _reason}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(TaggerWeb.ErrorView)
    |> render("500.json")
  end
end
