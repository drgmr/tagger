defmodule Tagger.Repo do
  use Ecto.Repo,
    otp_app: :tagger,
    adapter: Ecto.Adapters.Postgres
end
