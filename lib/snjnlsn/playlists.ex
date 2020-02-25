defmodule Snjnlsn.Playlists do
  @moduledoc """
  Public API Context for Spotify Playlist data
  """

  alias Snjnlsn.Playlists.Playlist

  defstruct items: [%Playlist{}]

  @doc """
  Returns list of Sanjay's playlists
  """
  @spec load(term()) :: __MODULE__.t()
  def load(token) do
    case Playlist.fetch_playlists(token) do
      {:ok, playlists} ->
        playlists

      {:error, reason} ->
        IO.puts("Error fetching playlist: ", reason)
    end
  end
end