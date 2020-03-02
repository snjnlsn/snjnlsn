defmodule SnjnlsnWeb.Router do
  use SnjnlsnWeb, :router
  alias SnjnlsnWeb.SpotifyAuthPlug
  require Logger

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipe_through :browser

  scope "/", SnjnlsnWeb do
    pipe_through [Ueberauth, SpotifyAuthPlug]
    live "/playlists", PlaylistLive
  end

  scope "/", SnjnlsnWeb do
    live "/", Live
  end

  scope "/auth", SnjnlsnWeb do
    get "/spotify", SpotifyController, :request
    get "/spotify/callback", SpotifyController, :callback
  end
end
