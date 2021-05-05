# Snjnlsn

Certain features require secure HTTPS/SSL. For local development, [`ngrok`](https://ngrok.com/) is reccomended. I've attached a makefile for brevity.

- Create a `config/secret.exs` and `config/prod.secret.exs` with required configuration like so:

  ```
    use Mix.Config

    config :snjnlsn, SnjnlsnWeb.Endpoint,
      secret_key_base: your_key_here,
      live_view: [signing_salt: your_other?_key_here]

    config :ueberauth, Ueberauth.Strategy.Spotify.OAuth,
      client_id: <ID FROM SPOTIFY>,
      client_secret: <SECRET FROM SPOTIFY>

    config :snjnlsn, Snjnlsn.Songwriter.Recording,
      goth: PATH_TO_NONPROD_GOOGLE_SERVICE_ACCT,
  ```

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && yarn`
- From one terminal window, navigate to NGROK's directory and run `./ngrok http 4000`.
- In another terminal, run `make serve-ngrok`
- Access the webapp from NGROK's endpoint
- NOTE: If ngrok is unnecessary, a standard `mix phx.server` will run the app as usual at the standard [`localhost:4000`](http://localhost:4000)

### Built on Phoenix Framework. Learn more at http://www.phoenixframework.org/
