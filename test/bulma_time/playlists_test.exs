defmodule BulmaTime.PlaylistsTest do
  use ExUnit.Case

  alias BulmaTime.Playlists
  alias BulmaTime.Playlists.Playlist

  describe "load/0" do
    test "returns list of Playlists from Spotify API" do
      for playlist <- Playlists.load() do
        assert %Playlist{} = playlist
      end
    end
  end
end
