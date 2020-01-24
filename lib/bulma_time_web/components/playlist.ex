defmodule BulmaTimeWeb.Playlist do
  use Surface.LiveView
  require IEx
  require Logger

  def mount(_session, socket) do
    IEx.pry
    {:ok, assign(socket, thing: 'test')}
  end

  def render(assigns) do
    ~H"""
      <div>
        <p>hello mofo</p>
      </div>
    """
  end
end
