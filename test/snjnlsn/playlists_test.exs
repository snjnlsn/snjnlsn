defmodule Snjnlsn.PlaylistsTest do
  use ExUnit.Case

  alias Snjnlsn.Playlists
  alias Snjnlsn.Playlists.Playlist

  # TODO: make mock success & failure responses

  describe "load/0" do
    test "returns list of Playlists from Spotify API" do
      for playlist <- Playlists.load() do
        assert %Playlist{} = playlist
      end
    end
  end
end
