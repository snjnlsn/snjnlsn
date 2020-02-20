defmodule SnjnlsnWeb.Button do
  use Phoenix.LiveComponent

  # property(click, :event)
  # property(kind, :string, default: "is-info")

  def mount(_, _, socket) do
    socket
  end

  def render(assigns) do
    ~L"""
    <button class="button {{ @kind }}" phx-click={{ @click }} style="margin: 0px 5px">
      {{ @inner_content.() }}
    </button>
    """
  end
end
