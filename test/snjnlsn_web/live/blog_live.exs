defmodule SnjnlsnWeb.BlogLiveTest do
  use SnjnlsnWeb.ConnCase
  import Phoenix.LiveViewTest
  alias Snjnlsn.Blog

  describe "BlogLive" do
    test "renders template", %{conn: conn} do
      {:ok, _view, html} = live(conn, "/blog")
      assert html =~ ~s(data-testid=\"BlogLive\")
    end

    test "renders each blog", %{conn: conn} do
      {:ok, _view, html} = live(conn, "/blog")
      for post <- Blog.list_posts(), do: assert(html =~ ~s(id=\"#{post.id}\"))
    end
  end
end
