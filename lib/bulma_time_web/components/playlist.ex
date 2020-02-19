defmodule BulmaTimeWeb.Component.Playlist do
  use Surface.LiveComponent

  property(playlist, :map)
  property(show, :boolean, default: false)
  property(images, :list)

  def mount(_, _, socket) do
    {:ok, assign(socket, show: false)}
  end

  @spec render(map) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    # image = Enum.find(assigns[:images], fn i -> i["height"] == 640 end)

    ~H"""
    <div class={{:tile, :hasBackgroundBlackBis, :isChild, :box}}>
      <h3 class={{"title", hasTextGrey: !@show}}>{{@playlist["name"]}}</h3>
      <div
        class={{:content}}
        :if={{ @show }}
        id={{"#{@playlist["name"]}-cond-div"}}
      >
        <p>{{@playlist["uri"]}}</p>
      </div>
    </div>
    """
  end
end
