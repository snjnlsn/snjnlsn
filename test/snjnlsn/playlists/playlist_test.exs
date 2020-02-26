defmodule Snjnlsn.PlaylistTest do
  use ExUnit.Case

  @success_response ~s(
    {"href":"https://api.spotify.com/v1/users/wizzler/playlists","items":[{"collaborative":false,"external_urls":{"spotify":"http://open.spotify.com/user/wizzler/playlists/53Y8wT46QIMz5H4WQ8O22c"},"href":"https://api.spotify.com/v1/users/wizzler/playlists/53Y8wT46QIMz5H4WQ8O22c","id":"53Y8wT46QIMz5H4WQ8O22c","images":[],"name":"Wizzlers Big Playlist","owner":{"external_urls":{"spotify":"http://open.spotify.com/user/wizzler"},"href":"https://api.spotify.com/v1/users/wizzler","id":"wizzler","type":"user","uri":"spotify:user:wizzler"},"public":true,"snapshot_id":"bNLWdmhh+HDsbHzhckXeDC0uyKyg4FjPI/KEsKjAE526usnz2LxwgyBoMShVL+z+","tracks":{"href":"https://api.spotify.com/v1/users/wizzler/playlists/53Y8wT46QIMz5H4WQ8O22c/tracks","total":30},"type":"playlist","uri":"spotify:user:wizzler:playlist:53Y8wT46QIMz5H4WQ8O22c"}],"limit":9,"next":null,"offset":0,"previous":null,"total":9}
  )

  @error_response ~s({
    "error": "invalid_client",
    "error_description": "Invalid client secret"
})

  defp endpoint_url(port), do: "http://localhost:#{port}/"

  alias Snjnlsn.Playlists.Playlist

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "fetch_playlists/2" do
    test "returns [%Playlist{}] for successful responses", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, @success_response)
      end)

      {:ok, playlists} = Playlist.fetch_playlists("", endpoint_url(bypass.port))

      for playlist <- playlists do
        assert %Playlist{} = playlist
      end
    end

    test "returns error tuple for bad API responses", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 400, @error_response)
      end)

      assert {:ok, []} = Playlist.fetch_playlists("", endpoint_url(bypass.port))
    end
  end
end
