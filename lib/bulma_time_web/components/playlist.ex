defmodule BulmaTimeWeb.Playlist do
  use Phoenix.LiveView
  require IEx

  def mount(_params, _session, socket) do
    IEx.pry
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div>
        <p>hello mofo</p>
      </div>
    """
  end
end
