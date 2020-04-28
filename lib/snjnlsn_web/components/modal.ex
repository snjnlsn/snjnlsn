defmodule SnjnlsnWeb.Modal do
  alias SnjnlsnWeb.Button
  use Phoenix.LiveComponent

  def mount(_, _, socket) do
    {:ok, assign(socket, show: false)}
  end

  # def render(assigns) do
  #   ~L"""
  #     <div class={{"modal", isActive: @show }}>
  #       <div class="modal-content">
  #         {{ @inner_content.() }}
  #       </div>
  #       <div class="modal-background"></div>
  #       <Button click="hide">im done</Button>
  #     </div>
  #   """
  # end

  def render(assigns) do
    ~L"""
    <p>hello</p>
    """
  end

  def handle_event("show", _, socket) do
    {:noreply, assign(socket, show: true)}
  end

  def handle_event("hide", _, socket) do
    {:noreply, assign(socket, show: false)}
  end
end
