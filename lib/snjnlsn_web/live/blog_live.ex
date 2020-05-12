defmodule SnjnlsnWeb.BlogLive do
  use Phoenix.LiveView
  alias Snjnlsn.Blog

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :posts, Blog.list_posts())}
  end

  def render(assigns) do
    ~L"""
      <div data-testid="BlogLive"></div>
    """
  end
end
