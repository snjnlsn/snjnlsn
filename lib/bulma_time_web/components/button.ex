defmodule BulmaTimeWeb.Button do
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
