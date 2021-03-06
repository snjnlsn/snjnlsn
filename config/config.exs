# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

key = Application.get_env(:my_app, :secret_key_base)

config :snjnlsn,
  ecto_repos: [Snjnlsn.Repo]

# Configures the endpoint
config :snjnlsn, SnjnlsnWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SnjnlsnWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Snjnlsn.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Ueberauth for Spotify
config :ueberauth, Ueberauth,
  providers: [
    spotify: {Ueberauth.Strategy.Spotify, [default_scope: ""]}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "secret.exs"
import_config "#{Mix.env()}.exs"
