defmodule BulmaTimeWeb.Live do
  use Phoenix.LiveView
  alias BulmaTimeWeb.Modal
  alias BulmaTimeWeb.Button
  alias BulmaTimeWeb.AOTY
  require IEx

  def mount(_, _, socket) do
    socket
  end

  # property :albums,  [
  #   "https://via.placeholder.com/420",
  #   "https://via.placeholder.com/420",
  #   "https://via.placeholder.com/420",
  #   "https://via.placeholder.com/420"
  # ]

  # def render(assigns) do
  #   # IEx.pry
  #   ~H"""
  #   <Modal id="modal">
  #   Haha Modal!
  #   </Modal>
  #   <AOTY id="idk" album_images={{[
  #     "http://placekitten.com/g/480/480",
  #     "http://placekitten.com/g/480/480",
  #     "http://placekitten.com/g/480/480",
  #     "http://placekitten.com/g/480/480"
  #   ]}} />
  #   <Button click="show">
  #     Modal!
  #   </Button>
  #   """
  # end

  def render(assigns) do
    ~L"""
      <div></div>
    """
  end

  def handle_event("show", _, socket) do
    send_update(Modal, id: "modal", show: true)
    {:noreply, socket}
  end
end
