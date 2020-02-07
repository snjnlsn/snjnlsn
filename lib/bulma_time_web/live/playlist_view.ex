defmodule BulmaTimeWeb.PlaylistView do
  use Surface.LiveView
  require HTTPoison
  require Jason
  require Logger

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
    Logger.info Enum.at(assigns[:playlists], 0) |> inspect
    ~H"""
      <p :for={{ playlist <- Enum.filter(@playlists, fn p -> p["public"] end) }}>
        {{ String.downcase playlist["name"] }}
      </p>
    """
  end
end
