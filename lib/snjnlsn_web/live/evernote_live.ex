defmodule SnjnlsnWeb.EvernoteLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    # %{"token" => token} = session

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    "Hello"
    """
  end
end
