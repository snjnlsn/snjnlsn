defmodule SnjnlsnWeb.PlaylistLive do
  use Surface.LiveView
  alias SnjnlsnWeb.Component.Playlist
  alias Snjnlsn.Playlists

  def mount(_params, session, socket) do
    {:ok, assign(socket, :playlists, Playlists.load(session["spotify_token"]))}
  end

  def render(assigns) do
    Phoenix.View.render(SnjnlsnWeb.PlaylistView, "index.html", assigns)
  end

  def handle_event("show", %{"name" => name}, socket) do
    # send_update(Playlist, id: name, Playlists.set_active(name))
    {:noreply, socket}
  end
end
