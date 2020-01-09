defmodule BulmaTimeWeb.Live do
  use Surface.LiveView
  alias BulmaTimeWeb.Modal
  alias BulmaTimeWeb.Button

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
