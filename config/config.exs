# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

key = "JYytuCxSlQg3hZQtrL3/sGZTeE+PK3p2Ot+tyTHlfA9oxEcii9QyPIPU/VLi5UCQ"

config :snjnlsn,
  ecto_repos: [Snjnlsn.Repo],
  playlist_url: "https://api.spotify.com/v1/users/smwus5mq52q7u9zymllzghwyr/playlists"

# Configures the endpoint
config :snjnlsn, SnjnlsnWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: key,
  live_view: [signing_salt: key],
  render_errors: [view: SnjnlsnWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Snjnlsn.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Ueberauth for Spotify
config :ueberauth, Ueberauth,
  providers: [
    spotify:
      {Ueberauth.Strategy.Spotify,
       [default_scope: "playlist-read-private,playlist-modify-private"]}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
