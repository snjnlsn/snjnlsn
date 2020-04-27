defmodule Snjnlsn.Playlists do
  @moduledoc """
  Public API Context for Spotify Playlist data
  """
  alias Snjnlsn.Playlists.Playlist

  @type t() :: %__MODULE__{ items: [%Playlist{}] }
  defstruct items: [%Playlist{}]

  @doc """
  Returns list of Sanjay's playlists
  """
  @spec load(term()) :: __MODULE__.t()
  def load(token) do
    case Playlist.fetch_playlists(token) do
      {:ok, list} ->
        list

      {:error, reason} ->
        []
    end
  end

  @doc """
  Returns requested playlist as active and sets any previously active playlists to inactiveß
  """
  @spec set_active(String.t()) :: Playlist.t()
  def set_active(playlist), do: Playlist.set_active(playlist)
end
