defmodule SnjnlsnWeb.Live do
  use Phoenix.LiveView
  alias SnjnlsnWeb.Modal
  alias SnjnlsnWeb.Button
  alias SnjnlsnWeb.AOTY
  require IEx

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    """
  end

  def handle_event("show", _, socket) do
    send_update(Modal, id: "modal", show: true)
    {:noreply, socket}
  end
end
