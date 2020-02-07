defmodule BulmaTimeWeb.Component.Playlist do
  use Surface.LiveComponent

  property(playlist, :map)
  property(show, :boolean)

  def mount(_,_, socket) do
    {:ok, assign(socket, show: false)}
  end

  def render(assigns) do
    ~H"""
      <div class={{"modal", isActive: @show }}>
        <div class="modal-content">
          {{ @playlist["name"] }}
        </div>
        <div class="modal-background"></div>
        <button click="hide">im done</button>
      </div>
    """
  end

  def handle_event("show", _, socket) do
    {:noreply, assign(socket, show: true)}
  end

  def handle_event("hide", _, socket) do
    {:noreply, assign(socket, show: false)}
  end
end
