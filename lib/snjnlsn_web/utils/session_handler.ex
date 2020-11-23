defmodule SnjnlsnWeb.SessionHandler do
  def pull(conn) do
    %Plug.Conn{
      assigns: %{
        spotify_auth: %{
          "access_token" => token
        }
      }
    } = conn

    %{"token" => token}
  end
end
