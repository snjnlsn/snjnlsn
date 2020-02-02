defmodule BulmaTimeWeb.PlaylistDisplay do
  use Phoenix.LiveView
  require IEx
  require Logger

  def mount(params, session, socket) do
    {:ok, assign(socket, playlists: get_playlists(session["spotify_auth"]))}
  end

  def render(assigns) do
    ~L"""
      <div>
        <p>hello mofo</p>
      </div>
    """
  end

  def get_playlists(auth) do
    url = Spotify.current_user()
    |> Spotify.Playlist.get_users_playlists_url()
    Spotify.Client.get(auth, url)
  end
end
