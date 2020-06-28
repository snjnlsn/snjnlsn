defmodule Snjnlsn.Playlists.Playlist do
  @moduledoc """
  Private logic for handling Spotify Playlists, to be used by public Playlists context
  """

  defstruct name: "",
            description: "",
            id: "",
            href: "",
            images: %{},
            tracks: %{},
            owner: %{},
            snapshot_id: "",
            active: false,
            public: false

  @type t() :: %__MODULE__{
          name: String.t(),
          description: String.t(),
          id: String.t(),
          href: String.t(),
          images: map(),
          tracks: map(),
          owner: map(),
          snapshot_id: String.t(),
          active: boolean(),
          public: boolean()
        }

  @doc """
  When Spotify API is successful, returns a list of playlists
  """
  @spec fetch_playlists(any, binary) :: {:error, HTTPoison.Error.t()} | {:ok, [any]}
  def fetch_playlists(
        token,
        url \\ "https://api.spotify.com/v1/users/smwus5mq52q7u9zymllzghwyr/playlists"
      ) do
    case HTTPoison.get(url, Authorization: "Bearer #{token}") do
      {:ok, response} ->
        {:ok, Poison.decode!(response.body, as: %{})["items"] |> Enum.map(&map_to_playlist/1)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec map_to_playlist(%{}) :: __MODULE__.t()
  defp map_to_playlist(playlist_map) do
    atomized = for {key, val} <- playlist_map, into: %{}, do: {String.to_atom(key), val}
    struct(__MODULE__, atomized)
  end

  @doc """
  returns a playlist marked as active
  """
  @spec set_active(__MODULE__.t()) :: __MODULE__.t()
  def set_active(playlist), do: %__MODULE__{playlist | :active => true}
end
