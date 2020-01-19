use Mix.Config

config :spotify_ex, user_id: "smwus5mq52q7u9zymllzghwyr",
                    scopes: ["playlist-read-private", "playlist-modify-private"],
                    callback_url: "http://localhost:4000/authenticate"
