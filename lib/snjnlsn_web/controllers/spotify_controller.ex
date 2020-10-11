defmodule SnjnlsnWeb.SpotifyController do
  use SnjnlsnWeb, :controller
  plug Ueberauth
  alias Ueberauth.Strategy.Helpers
  require URI

  # def request(conn, _params) do
  #   IO.inspect(conn, label: "\n\n\n hello!!! \n\n\n\n")
  #   render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  # end

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
    # %{
    #   assigns: %{
    #     ueberauth_auth: %Ueberauth.Auth{
    #       credentials: %Ueberauth.Auth.Credentials{expires_at: expiration}
    #     }
    #   }
    # } = conn

    # IO.inspect(expiration, label: "heres your fucking \n\n\n CONN \n\n\n ")

    # TODO: remove auth from session if i can pull it off conn in liveview? ueberauth puts it there by default

    conn
    |> put_session(:spotify_token, auth.credentials)
    |> configure_session(renew: true)
    |> redirect(to: "/playlists")
  end
end
