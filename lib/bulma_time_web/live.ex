defmodule Button do
  use Surface.Component

  property(click, :event)
  property(kind, :string, default: "is-info")


  def render(assigns) do
    ~H"""
    <button class="button {{ @kind }}" phx-click={{ @click }} style="margin: 0px 5px">
      {{ @inner_content.() }}
    </button>
    """
  end
end

defmodule Modal do
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
        <Button css_class="test" click="hide">im done</Button>
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

defmodule BulmaTimeWeb.Live do
  use Surface.LiveView

  # def mount(_session, socket) do
  #   {:ok, assign(socket, rounded: true)}
  # end

  def render(assigns) do
    ~H"""
    <Modal id="modal">
      Haha Modal!
    </Modal>
    <Button click="show">
      Modal!
    </Button>
    """
  end

  def handle_event("show", _, socket) do
    send_update(Modal, id: "modal", show: true)
    {:noreply, socket}
  end
end
