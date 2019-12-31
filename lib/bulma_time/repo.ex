defmodule BulmaTime.Repo do
  use Ecto.Repo,
    otp_app: :bulma_time,
    adapter: Ecto.Adapters.Postgres
end
