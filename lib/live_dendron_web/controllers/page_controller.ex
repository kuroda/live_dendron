defmodule LiveDendronWeb.PageController do
  use LiveDendronWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
