defmodule BulmaTimeWeb.Component.Playlist do
  use Surface.LiveComponent

  require Logger

  property(playlist, :map)
  property(show, :boolean)

  def mount(_,_, socket) do
    {:ok, assign(socket, show: false)}
  end

  # def render(assigns) do
  #   ~H"""
  #   <div :if={{ @show}} id={{@playlist["name"]}}>
  #     {{ @playlist["name"] }}
  #   </div>
  #   """
  # end

  def render(assigns) do
    ~H"""
      <p>hello</p>
    """
  end

  def handle_event("show", _, socket) do
    Logger.info "show"
    {:noreply, assign(socket, show: true)}
  end

  def handle_event("hide", _, socket) do
    Logger.info "hide"
    {:noreply, assign(socket, show: false)}
  end
end
