use Mix.Config

# Configure your database
config :bulma_time, BulmaTime.Repo,
  username: "postgres",
  password: "postgres",
  database: "bulma_time_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bulma_time, BulmaTimeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
