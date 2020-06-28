defmodule SnjnlsnWeb.PlaylistComponent do
  use Phoenix.LiveComponent

  def mount(_, _, socket) do
    {:ok, socket}
  end

  @spec render(map) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
      <div
      class="playlist-body"
      id="<%= "#{@playlist.name}-cond-div" %>"
      >
      <img src="<%= List.first(@playlist.images) |> Map.get("url") %>" />
    </div>
    """
  end
end
