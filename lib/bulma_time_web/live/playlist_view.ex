defmodule BulmaTimeWeb.PlaylistView do
  use Surface.LiveView
  require HTTPoison
  require Jason
  require Logger
  require IEx
  alias BulmaTimeWeb.Component.Playlist

  @playlist_url "https://api.spotify.com/v1/users/smwus5mq52q7u9zymllzghwyr/playlists"

  def mount(_params, session, socket) do
    playlists = get_playlists(session["spotify_token"])
    {:ok, assign(socket, :playlists, playlists)}
  end

  defp get_playlists(token) do
    case HTTPoison.get(@playlist_url,
           Authorization: "Bearer #{token}"
         ) do
      {:ok, response} ->
        Jason.decode!(response.body)["items"]

      {:error, reason} ->
        {:error, reason}
    end
  end

  def render(assigns) do
    ~H"""
      <div class={{:tile, :isAncestor, :isVertical}}>
        <div :for={{ %{"name" => name, "images" => images} = playlist <- Enum.filter(@playlists, fn p -> p["public"] end)}}
          phx-debounce="20000"
          phx-hook="playlistTitle"
          phx-value-name={{name}}
          id={{"#{name}-div"}}
          class="tile is-parent"
        >
          <Playlist playlist={{playlist}} images={{images}} id={{name}}/>
        </div>
      </div>
    """
  end

  def handle_event("show", %{"name" => name}, socket) do
    send_update(Playlist, id: name, show: true)
    {:noreply, socket}
  end

  def handle_event("hide", %{"name" => name}, socket) do
    send_update(Playlist, id: name, show: false)
    {:noreply, socket}
  end
end
