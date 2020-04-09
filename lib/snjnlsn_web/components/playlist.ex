defmodule SnjnlsnWeb.PlaylistComponent do
  use Surface.LiveComponent

  property(playlist, :any)

  def mount(_, _, socket) do
    {:ok, socket}
  end

  @spec render(map) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
      <div
      class="playlist-body"
      id={{"#{@playlist.name}-cond-div"}}
      data-image={{List.first(@playlist.images) |> Map.get("url")}}
      >
    </div>
    """
  end
end
