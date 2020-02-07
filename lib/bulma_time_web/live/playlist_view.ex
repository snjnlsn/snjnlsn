defmodule BulmaTimeWeb.PlaylistView do
  use Surface.LiveView
  require HTTPoison
  require Jason
  require Logger
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
    Logger.info(Enum.at(assigns[:playlists], 0) |> inspect)

    ~H"""
      <div :for={{ playlist <- Enum.filter(@playlists, fn p -> p["public"] end) }}>
        <Playlist playlist={{playlist}} id={{playlist["name"]}}/>
        <button phx-click="show">show {{playlist["name"]}}</button>
      </div>
    """
  end
end
