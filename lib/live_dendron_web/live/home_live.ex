defmodule LiveDendronWeb.HomeLive do
  use Phoenix.LiveView

  def render(assigns), do: LiveDendronWeb.HomeLiveView.render("main.html", assigns)

  def mount(_session, socket) do
    {:ok, socket}
  end
end
