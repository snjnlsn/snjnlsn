defmodule BulmaTimeWeb.SpotifyController do
  use BulmaTimeWeb, :controller

  def authenticate(conn, params) do
    {conn, path} =
      case Spotify.Authentication.authenticate(conn, params) do
        {:ok, conn} ->
          conn = put_status(conn, 301)
          {conn, "/"}

        {:error, reason, conn} ->
          {conn, "/"}
      end

    redirect(conn, to: path)
  end

  def authorize(conn, _params) do
    redirect conn, external: Spotify.Authorization.url
  end
end
