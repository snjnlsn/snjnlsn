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
      <div :for={{ %{"name" => name} = playlist <- Enum.filter(@playlists, fn p -> p["public"] end) }}>
        <Playlist playlist={{playlist}} id={{name}}/>
        <span
          class="playlist-title"
          phx-hook="Hover"
          phx-value-name={{name}}
        >
          {{name}}
        </span>
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
