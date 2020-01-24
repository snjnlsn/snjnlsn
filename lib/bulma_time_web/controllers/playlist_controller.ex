defmodule BulmaTimeWeb.PlaylistController do
  use BulmaTimeWeb, :controller

  def index(conn, _params) do
    live_render(conn, BulmaTimeWeb.Playlist)
  end
end
