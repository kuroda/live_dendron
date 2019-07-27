defmodule LiveDendronWeb.HomeLive do
  use Phoenix.LiveView
  alias LiveDendron.Core

  def render(assigns), do: LiveDendronWeb.HomeLiveView.render("main.html", assigns)

  def mount(_session, socket) do
    socket = assign(socket, :teams, Core.list_teams())

    {:ok, socket}
  end
end
