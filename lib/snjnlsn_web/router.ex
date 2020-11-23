defmodule SnjnlsnWeb.Router do
  use SnjnlsnWeb, :router
  alias SnjnlsnWeb.SpotifyAuthPlug

  pipeline :browser do
    plug :put_root_layout, {SnjnlsnWeb.LayoutView, :root}
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
    live "/playlists", PlaylistLive, session: {SnjnlsnWeb.SessionHandler, :pull, []}
    # get "/playlists", SpotifyController, :request
    live "/blog", BlogLive
  end

  scope "/", SnjnlsnWeb do
    live "/", Live
  end

  scope "/auth", SnjnlsnWeb do
    get "/spotify", SpotifyController, :request
    get "/spotify/callback", SpotifyController, :callback
  end
end
