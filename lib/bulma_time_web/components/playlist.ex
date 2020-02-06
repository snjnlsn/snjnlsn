defmodule BulmaTimeWeb.Component.Playlist do
  use Surface.LiveComponent
  require Logger
  # property playlist, :map

  def mount(_, _, socket) do

    # handle parsing of playlist into various fields :-)
    {:ok, socket}
  end

  def render(assigns) do
    Logger.info assigns
    ~H"""
      <p>hello</p>
    """
  end
end
