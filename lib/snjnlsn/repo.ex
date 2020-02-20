defmodule Snjnlsn.Repo do
  use Ecto.Repo,
    otp_app: :snjnlsn,
    adapter: Ecto.Adapters.Postgres
end
