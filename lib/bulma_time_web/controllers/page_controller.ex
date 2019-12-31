defmodule BulmaTimeWeb.PageController do
  use BulmaTimeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
