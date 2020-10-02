# Snjnlsn

To start:

- Create a `config/secret.exs` with secret key configuration for phoenix and live_view like so:
  ```
    config :snjnlsn, SnjnlsnWeb.Endpoint,
    secret_key_base: your_key_here,
    live_view: [signing_salt: your_other?_key_here]
  ```
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && yarn`
- Start Phoenix endpoint with `mix phx.server`
- Visit [`localhost:4000`](http://localhost:4000) from your browser

### Built on Phoenix Framework. Learn more at http://www.phoenixframework.org/
