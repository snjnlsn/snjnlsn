defmodule BulmaTimeWeb.Modal do
  alias BulmaTimeWeb.Button
  use Surface.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, show: false)}
  end

  def render(assigns) do
    ~H"""
      <div class={{"modal", isActive: @show }}>
        <div class="modal-content">
          {{ @inner_content.() }}
        </div>
        <div class="modal-background"></div>
        <Button click="hide">im done</Button>
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

