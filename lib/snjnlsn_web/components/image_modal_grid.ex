defmodule SnjnlsnWeb.AOTY do
  use Phoenix.LiveComponent

  # property(album_images, :list)

  def mount(_, _, socket) do
    {:ok, assign(socket, show: false)}
  end

  # def render(assigns) do
  #   ~H"""
  #     <div :for={{ item <- @album_images }}>
  #     <figure class="image is-square">
  #       <img src={{item}} alt="" phx-click="show"/>
  #     </figure>
  #     <div class={{"modal", isActive: @show }}>
  #       <div class="modal-background"></div>
  #       <div class="modal-content">
  #         <figure class="image is-square">
  #           <img src={{item}} alt=""/>
  #         </figure>
  #         <button class="is-large" phx-click="hide" aria-label="close">Cool but im done</button>
  #       </div>
  #     </div>
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
