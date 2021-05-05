defmodule SnjnlsnWeb.Router do
  use SnjnlsnWeb, :router

  import SnjnlsnWeb.UserAuth
  alias SnjnlsnWeb.SpotifyAuthPlug

  pipeline :browser do
    plug :put_root_layout, {SnjnlsnWeb.LayoutView, :root}
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SnjnlsnWeb do
    pipe_through [:browser, Ueberauth, SpotifyAuthPlug]
    live "/playlists", PlaylistLive, session: {SnjnlsnWeb.SessionHandler, :pull, []}
    # get "/playlists", SpotifyController, :request
    live "/blog", BlogLive
  end

  scope "/", SnjnlsnWeb do
    pipe_through :browser
    live "/", Live
  end

  scope "/auth", SnjnlsnWeb do
    get "/spotify", SpotifyController, :request
    get "/spotify/callback", SpotifyController, :callback
  end

  ## Authentication routes

  scope "/", SnjnlsnWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", SnjnlsnWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/admin", SnjnlsnWeb do
    # pipe_through [:browser, :require_authenticated_user, :require_admin_user]

    # (for testing w/o auth)
    pipe_through :browser

    live "/evernote", EvernoteLive
    live "/recordings", RecordingLive.Index, :index
    live "/recordings/new", RecordingLive.Index, :new
    live "/recordings/:id/edit", RecordingLive.Index, :edit
    live "/recordings/:id", RecordingLive.Show, :show
    live "/recordings/:id/show/edit", RecordingLive.Show, :edit
  end

  scope "/", SnjnlsnWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
