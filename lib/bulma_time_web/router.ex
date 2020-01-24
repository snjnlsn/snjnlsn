defmodule BulmaTimeWeb.Router do
  use BulmaTimeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipe_through :browser

  scope "/", BulmaTimeWeb do
    pipe_through BulmaTimeWeb.Plugs.SpotifyAuth

    live "/", Live
    get "/playlists", PlaylistController, :index
  end

  scope "/", BulmaTimeWeb do
    get "/authenticate", SpotifyController, :authenticate
    get "/authorize", SpotifyControler, :authorize
  end

  # Other scopes may use custom stacks.
  # scope "/api", BulmaTimeWeb do
  #   pipe_through :api
  # end
end
