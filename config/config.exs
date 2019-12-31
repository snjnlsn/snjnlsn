# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bulma_time,
  ecto_repos: [BulmaTime.Repo]

# Configures the endpoint
config :bulma_time, BulmaTimeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JYytuCxSlQg3hZQtrL3/sGZTeE+PK3p2Ot+tyTHlfA9oxEcii9QyPIPU/VLi5UCQ",
  live_view: [signing_salt: :secret_key_base],
  render_errors: [view: BulmaTimeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BulmaTime.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
