defmodule Snjnlsn.Playlists.Playlist do
  @moduledoc """
  Private logic for handling Spotify Playlists, to be used by public Playlists context
  """

  require IEx
  @playlist_url "https://api.spotify.com/v1/users/smwus5mq52q7u9zymllzghwyr/playlists"

  defstruct name: "",
            description: "",
            id: "",
            href: "",
            images: %{},
            tracks: %{},
            snapshot_id: "",
            current: false,
            public: false

  @type t() :: %__MODULE__{
          name: String.t(),
          description: String.t(),
          id: String.t(),
          href: String.t(),
          images: map(),
          tracks: map(),
          snapshot_id: String.t(),
          current: boolean(),
          public: boolean()
        }

  def fetch_playlists(token) do
    case HTTPoison.get(@playlist_url,
           Authorization: "Bearer #{token}"
         ) do
      {:ok, response} ->
        {:ok,
         Poison.decode!(response.body, as: %Snjnlsn.Playlists{}).items
         |> Enum.filter(fn p -> p.public end)}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
