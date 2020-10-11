defmodule SnjnlsnWeb.PlaylistLive do
  use Phoenix.LiveView
  alias SnjnlsnWeb.PlaylistComponent
  alias Snjnlsn.Playlists

  def mount(_params, session, socket) do
    # if expires_at does not exist or is less than :os.system_time(:millisecond) then redirect to auth which will callback

    # TODO: remove auth from session if i can pull it off conn in liveview? ueberauth puts it there by default

    %{"spotify_token" => %Ueberauth.Auth.Credentials{token: token}} = session

    playlists = Playlists.load(token)
    {:ok, assign(socket, :playlists, playlists)}
  end

  2

  def render(assigns) do
    ~L"""
      <%= for playlist <- @playlists do %>
        <div
          phx-click="click"
          phx-value-name="<%=playlist.name%>"
          id="<%= #{playlist.name}-div %>"
          class="tile is-parent"
        >
          <%= live_component @socket, PlaylistComponent, playlist: playlist %>
        </div>
      <%= end %>
    """
  end

  def handle_event("show", %{"name" => name}, socket) do
    # send_update(Playlist, id: name, Playlists.set_active(name))
    {:noreply, socket}
  end
end
