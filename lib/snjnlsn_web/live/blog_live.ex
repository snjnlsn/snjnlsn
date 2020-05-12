defmodule SnjnlsnWeb.BlogLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Tag
  alias Snjnlsn.Blog

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :posts, Blog.list_posts())}
  end

  def render(assigns) do
    ~L"""
      <div data-testid="BlogLive">
        <%= for post <- @posts do %>
          <div id="<%= post.id %>" >
            <h1><%= post.title %></h1>
            <%= content_tag :p, post.body %>
          </div>
        <% end %>
      </div>
    """
  end
end
