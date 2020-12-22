defmodule Vibers.Repo do
  use Ecto.Repo,
    otp_app: :vibers,
    adapter: Ecto.Adapters.Postgres
end
