defmodule BulmaTimeWeb.PlaylistDisplay do
  use Phoenix.LiveView
  require IEx
  require HTTPoison
  require Jason

  @playlist_url "https://api.spotify.com/v1/users/smwus5mq52q7u9zymllzghwyr/playlists"

  def mount(_params, session, socket) do
    {:ok, assign(socket, :playlists, get_playlists(session["spotify_token"]))}
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
    ~L"""
      <p><%= @playlists %></p>
    """
  end
end
