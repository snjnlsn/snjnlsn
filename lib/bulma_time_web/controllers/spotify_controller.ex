defmodule BulmaTimeWeb.SpotifyController do
  use BulmaTimeWeb, :controller
  plug Ueberauth
  alias Ueberauth.Strategy.Helpers
  require Logger

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  # def delete(conn, _params) do
  #   conn
  #   |> put_flash(:info, "You have been logged out!")
  #   |> clear_session()
  #   |> redirect(to: "/")
  # end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
      conn
      |> put_flash(:info, "Successfully authenticated.")
      |> put_session(:spotify_token, auth.credentials.token)
      |> configure_session(renew: true)
      |> redirect(to: "/")
  end
end
