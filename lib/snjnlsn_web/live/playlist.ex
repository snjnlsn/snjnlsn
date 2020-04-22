defmodule SnjnlsnWeb.PlaylistLive do
  use Surface.LiveView
  alias SnjnlsnWeb.PlaylistComponent
  alias Snjnlsn.Playlists

  def mount(_params, session, socket) do
    playlists = Playlists.load(session["spotify_token"])
    {:ok, assign(socket, :playlists, playlists)}
  end

  def render(assigns) do
    IO.inspect List.first(assigns.playlists)
    ~H"""
      <div class={{:tile, :isAncestor, :isVertical}}>
        <div :for={{ playlist <- @playlists }}
          phx-debounce="20000"
          phx-click="click"
          phx-value-name={{playlist.name}}
          id={{"#{playlist.name}-div"}}
          class="tile is-parent"
        >
          <PlaylistComponent playlist={{playlist}}/>
        </div>
      </div>
    """
  end

  def handle_event("show", %{"name" => name}, socket) do
    # send_update(Playlist, id: name, Playlists.set_active(name))
    {:noreply, socket}
  end
end
