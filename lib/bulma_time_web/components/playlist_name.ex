defmodule BulmaTimeWeb.PlaylistName do
  use Surface.LiveComponent
  
  def mount(socket) do
    {:ok, assign(socket, show: Spotify.Playlist.)}
  end
  
end