defmodule SnjnlsnWeb.PageController do
  use SnjnlsnWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
