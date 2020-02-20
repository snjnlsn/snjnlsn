defmodule SnjnlsnWeb.SpotifyAuthPlug do
  import Plug.Conn
  def init(default), do: default

  def call(conn, _default) do
    # IO.puts conn, "helllll ya"
    # Phoenix.Controller.redirect(conn, to: "/auth/spotify")
    conn
  end
end
