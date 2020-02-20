defmodule BulmaTime.Playlists.Playlist do
  @moduledoc """
  Private logic for handling Spotify Playlists, to be used by public Playlists context
  """

  defstruct name: "",
            description: "",
            id: "",
            href: "",
            images: %{},
            tracks: %{},
            snapshot_id: "",
            current: false

  @type t() :: %__MODULE__{
          name: String.t(),
          description: String.t(),
          id: String.t(),
          href: String.t(),
          images: map(),
          tracks: map(),
          snapshot_id: String.t(),
          current: boolean()
        }

  def fetch_playlists, do: [%__MODULE__{}, %__MODULE__{}]
end
