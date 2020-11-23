defmodule SnjnlsnWeb.SpotifyAuthPlug do
  import Plug.Conn
  def init(default), do: default

  def fetch_auth() do
    creds = Application.get_env(:ueberauth, Ueberauth.Strategy.Spotify.OAuth)
    encoded_creds = "Basic " <> Base.encode64(creds[:client_id] <> ":" <> creds[:client_secret])
    req_body = {:form, [{"grant_type", "client_credentials"}]}

    case HTTPoison.post("https://accounts.spotify.com/api/token", req_body,
           Authorization: encoded_creds
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: resp_body}} ->
        {:ok, decoded_resp} = Jason.decode(resp_body)
        decoded_resp

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")
        %{}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        %{}

      {:ok, anything} ->
        nil
        # IO.inspect(anything, label: "\n\n what \n\n")
    end
  end

  def call(conn, _default) do
    time = :os.system_time(:second)

    case conn do
      %Plug.Conn{
        assigns: %{
          spotify_auth: %{
            expires_in: expiration
          }
        }
      }
      when expiration >= time ->
        IO.puts("\n\n\n\n\n\n\n hello? \n\n\n\n\n\n\n")
        conn

      _ ->
        auth = fetch_auth()
        assign(conn, :spotify_auth, auth)
    end
  end
end
