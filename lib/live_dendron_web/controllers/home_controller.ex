defmodule LiveDendronWeb.HomeController do
  use LiveDendronWeb, :controller

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
