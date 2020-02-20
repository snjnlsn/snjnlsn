defmodule Snjnlsn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, args) do
    default_children = [
      # Start the Ecto repository
      Snjnlsn.Repo,
      # Start the endpoint when the application starts
      SnjnlsnWeb.Endpoint
      # Starts a worker by calling: Snjnlsn.Worker.start_link(arg)
      # {Snjnlsn.Worker, arg},
    ]

    # List all child processes to be supervised
    children = case args do
      [env: :test] -> [{Plug.Cowboy, scheme: :https, plug: Snjnlsn.SpotifyMockServer, options: [port: 8081]}] ++ default_children
      [_] -> default_children
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Snjnlsn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SnjnlsnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
