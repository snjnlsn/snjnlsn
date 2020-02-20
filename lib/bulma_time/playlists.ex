defmodule BulmaTime.Playlists do
  @moduledoc """
  Public API Context for Spotify Playlist data
  """

  alias BulmaTime.Playlists.Playlist

  @doc """
  Returns list of Sanjay's playlists
  """
  @spec load() :: [%Playlist{}]
  def load do
    [%Playlist{}]
  end
end
