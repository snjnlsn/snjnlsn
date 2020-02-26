defmodule Snjnlsn.Playlists.Playlist do
  @moduledoc """
  Private logic for handling Spotify Playlists, to be used by public Playlists context
  """

  require IEx
  @playlist_url Application.get_env(:snjnsln, :playlist_url)

  defstruct name: "",
            description: "",
            id: "",
            href: "",
            images: %{},
            tracks: %{},
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
          snapshot_id: String.t(),
          active: boolean(),
          public: boolean()
        }

  @doc """
  When Spotify API is successful, returns a list of playlists
  """
  @spec fetch_playlists(any, binary) :: {:error, HTTPoison.Error.t()} | {:ok, [any]}
  def fetch_playlists(token, url \\ @playlist_url) do
    case HTTPoison.get(url,
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

  @doc """
  returns a playlist marked as active
  """
  @spec set_active(__MODULE__.t()) :: __MODULE__.t()
  def set_active(playlist), do: %__MODULE__{playlist | :active => true}
end
