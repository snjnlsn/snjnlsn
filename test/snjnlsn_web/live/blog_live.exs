defmodule SnjnlsnWeb.BlogLiveTest do
  use SnjnlsnWeb.ConnCase
  import Phoenix.LiveViewTest
  alias Snjnsln.Blog

  describe "BlogLive" do
    test "renders template", %{conn: conn} do
      {:ok, _view, html} = live(conn, "/blog")
      assert html =~ ~s(data-testid=\"BlogLive\")
    end
  end
end
