defmodule BulmaTimeWeb.Live do
  use Phoenix.LiveView
  require Logger

  def mount(_session, socket) do
    Logger.info("MOUNT #{inspect(self())}")

    socket =
      socket
      |> assign(:counter, 0)
      |> IO.inspect()

    {:ok, socket}
  end

  def render(assigns) do
    Logger.info("RENDER #{inspect(self())}")

    ~L"""
    <label>Counter: <%= @counter %></label>
    <button phx-click="incr">+</button>
    """
  end

  def handle_event("incr", _eventj, socket) do
    socket = update(socket, :counter, &(&1 + 1))
    {:noreply, socket}
  end
end
