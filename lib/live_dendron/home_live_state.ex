defmodule LiveDendron.HomeLiveState do
  alias LiveDendron.Core

  defstruct teams: [], selected_team_id: nil

  def construct() do
    %__MODULE__{
      teams: Core.list_teams()
    }
  end

  def select_team(%__MODULE__{} = state, "") do
    %{state | selected_team_id: nil}
  end

  def select_team(%__MODULE__{} = state, id) do
    team = Enum.find(state.teams, fn t -> t.id == id end)
    %{state | selected_team_id: team.id}
  end

  def toggle_team_field(%__MODULE__{selected_team_id: nil} = state, _field), do: state

  def toggle_team_field(%__MODULE__{} = state, "being_edited") do
    teams = Enum.map(state.teams, fn team ->
      if team.id == state.selected_team_id do
        if team.being_edited do
          %{team | being_edited: false}
        else
          %{team | being_edited: true, changeset: Core.Team.changeset(team, %{})}
        end
      else
        team
      end
    end)

    %{state | teams: teams}
  end

  def update_team_name(%__MODULE__{selected_team_id: id} = state, %{"name" => name}) do
    team = Enum.find(state.teams, fn t -> t.id == id end)

    case Core.update_team_name(team, name) do
      {:ok, struct} -> replace_team(state, struct)
      {:error, changeset} -> replace_team(state, changeset)
    end
  end

  defp replace_team(%__MODULE__{selected_team_id: id} = state, %Core.Team{} = team) do
    team = %{team | being_edited: false, changeset: nil}

    teams = Enum.map(state.teams, fn t ->
      if t.id == id, do: team, else: t
    end)

    %{state | teams: teams}
  end

  defp replace_team(%__MODULE__{selected_team_id: id} = state, %Ecto.Changeset{} = cs) do
    teams = Enum.map(state.teams, fn t ->
      if t.id == id, do: %{t | changeset: cs}, else: t
    end)

    %{state | teams: teams}
  end
end
