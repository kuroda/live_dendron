defmodule LiveDendronWeb.HomeLive do
  use Phoenix.LiveView
  alias LiveDendron.Core
  alias LiveDendron.TeamEditor
  alias LiveDendron.Tree

  def render(assigns), do: LiveDendronWeb.HomeLiveView.render("main.html", assigns)

  def mount(_session, socket) do
    socket =
      socket
      |> assign(:teams, Core.list_teams())
      |> assign(:team_editor, nil)

    {:ok, socket}
  end

  @doc false
  def handle_event("select_team", "", socket), do: assign(socket, :team_editor, nil)

  def handle_event("select_team", id, socket) do
    team = Enum.find(socket.assigns.teams, fn t -> t.id == id end)
    socket = assign(socket, :team_editor, TeamEditor.construct(team))
    {:noreply, socket}
  end

  def handle_event("toggle_team_field", "activated", socket) do
    socket =
      update(socket, :team_editor, fn team_editor ->
        TeamEditor.toggle_activated(team_editor)
      end)

    {:noreply, socket}
  end

  def handle_event("update_team_name", %{"team" => team_params} = _params, socket) do
    socket =
      case TeamEditor.update_team_name(socket.assigns.team_editor, team_params) do
        {:ok, struct} -> replace_team(socket, struct)
        {:error, changeset} -> replace_team(socket, changeset)
      end

    {:noreply, socket}
  end

  def handle_event("toggle_group_expanded", uuid, socket) do
    socket =
      update(socket, :team_editor, fn team_editor ->
        Tree.toggle_group_expanded(team_editor, uuid)
      end)

    {:noreply, socket}
  end

  defp replace_team(socket, %Core.Team{} = struct) do
    teams =
      socket.assigns.teams
      |> Enum.map(fn t -> if t.id == struct.id, do: struct, else: t end)
      |> Enum.sort(fn a, b -> a.name <= b.name end)

    socket
    |> assign(:teams, teams)
    |> assign(:team_editor, TeamEditor.construct(struct))
  end

  defp replace_team(socket, %Ecto.Changeset{} = changeset) do
    update(socket, :team_editor, fn team_editor ->
      %{team_editor | changeset: changeset}
    end)
  end
end
