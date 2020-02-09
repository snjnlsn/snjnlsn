defmodule BulmaTimeWeb.Component.Playlist do
  use Surface.LiveComponent

  property(playlist, :map)
  property(show, :boolean, default: false)
  property(images, :list)

  def mount(_, _, socket) do
    {:ok, assign(socket, show: false)}
  end

  def render(assigns) do
    image = Enum.find(assigns[:images], fn i -> i["height"] == 640 end)

    ~H"""
    <div>
      {{ @inner_content.() }}
      <div
        :if={{ @show }}
        id={{"#{@playlist["name"]}-cond-div"}}
      >
        <img src={{image["url"]}} alt="cover of playlist" />
      </div>
    </div>
    """
  end
end
