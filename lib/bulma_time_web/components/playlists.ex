defmodule BulmaTimeWeb.Component.Playlists do
  use Surface.LiveComponent

  require IEx

  property playlists, :list

  @spec mount(any, any, any) :: {:ok, any}
  def mount(_, _, socket) do
    IEx.pry
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <li :for={{ _ <- [0, 'fuck', 12213] }}>
      <p>lol</p>
    </li>
    """
  end
end
