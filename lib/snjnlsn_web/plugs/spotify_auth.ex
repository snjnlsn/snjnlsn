defmodule SnjnlsnWeb.SpotifyAuthPlug do
  import Plug.Conn
  def init(default), do: default

  def call(conn, _default) do
    # Phoenix.Controller.redirect(conn, to: "/auth/spotify")
    conn
  end
end
