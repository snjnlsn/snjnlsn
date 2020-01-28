defmodule BulmaTimeWeb.Playlist do
  use Phoenix.LiveView
  require IEx
  require Logger

  def mount(_params, session, socket) do
    %{:spotify_auth => auth} = session
    %{:access_token => token, :refresh_token => refresh_token} = auth
    Logger.info("token: #{token}, refresh_token: #{refresh_token}")
    {:ok, assign(socket, user_session: session)}
  end

  def render(assigns) do
    # IEx.pry
    ~L"""
      <div>
        <p>hello mofo</p>
      </div>
    """
  end
end
