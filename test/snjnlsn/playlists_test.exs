defmodule Snjnlsn.PlaylistsTest do
  use ExUnit.Case

  alias Snjnlsn.Playlists

  describe "set_active/1" do
    test "sets :active to true" do
      playlist = %Playlists.Playlist{}
      assert %Playlists.Playlist{:active => true} = Playlists.set_active(playlist)
    end
  end
end
