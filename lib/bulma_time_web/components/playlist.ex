defmodule BulmaTimeWeb.Component.Playlist do
  use Surface.LiveComponent

  property(playlist, :any)

  def mount(_, _, socket) do
    {:ok, socket}
  end

  @spec render(map) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div class={{:tile, :hasBackgroundBlackBis, :isChild, :box}}>
      <h3 class={{"title", hasTextGrey: !@playlist.current}}>{{@playlist.name}}</h3>
      <div
        class={{:content}}
        id={{"#{@playlist.name}-cond-div"}}
      >
        <p>{{@playlist.href}}</p>
      </div>
    </div>
    """
  end
end
