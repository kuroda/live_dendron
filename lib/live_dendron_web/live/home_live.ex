defmodule LiveDendronWeb.HomeLive do
  use Phoenix.LiveView
  alias LiveDendron.HomeLiveState

  def render(assigns), do: LiveDendronWeb.HomeLiveView.render("main.html", assigns)

  def mount(_session, socket) do
    socket = assign(socket, :state, HomeLiveState.construct())

    {:ok, socket}
  end

  def handle_event("select_team", id, socket) do
    socket =
      update(socket, :state, fn state ->
        HomeLiveState.select_team(state, id)
      end)

    {:noreply, socket}
  end

  def handle_event("toggle_team_field", "being_edited" = field, socket) do
    socket =
      update(socket, :state, fn state ->
        HomeLiveState.toggle_team_field(state, field)
      end)

    {:noreply, socket}
  end
end
