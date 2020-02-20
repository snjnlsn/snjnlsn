defmodule BulmaTimeWeb.PlaylistLive do
  use Surface.LiveView
  alias BulmaTimeWeb.Component.Playlist
  alias BulmaTime.Playlists

  def mount(_params, session, socket) do
    {:ok, assign(socket, :playlists, Playlists.load(session["spotify_token"]))}
  end

  def render(assigns) do
    ~H"""
      <div class={{:tile, :isAncestor, :isVertical}}>
        <div :for={{ playlist <- @playlists}}
          phx-debounce="20000"
          phx-hook="playlistTitle"
          phx-value-name={{playlist.name}}
          id={{"#{playlist.name}-div"}}
          class="tile is-parent"
        >
          <Playlist playlist={{playlist}}/>
        </div>
      </div>
    """
  end

  # def handle_event("show", %{"name" => name}, socket) do
  #   send_update(Playlist, id: name, show: true)
  #   {:noreply, socket}
  # end

  # def handle_event("hide", %{"name" => name}, socket) do
  #   send_update(Playlist, id: name, show: false)
  #   {:noreply, socket}
  # end
end
