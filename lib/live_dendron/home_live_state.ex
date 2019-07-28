defmodule LiveDendron.HomeLiveState do
  alias LiveDendron.Core

  defstruct teams: [], selected_team: nil

  def construct() do
    %__MODULE__{
      teams: Core.list_teams()
    }
  end

  def select_team(%__MODULE__{} = state, "") do
    %{state | selected_team: nil}
  end

  def select_team(%__MODULE__{} = state, id) do
    team = Enum.find(state.teams, fn t -> t.id == id end)
    %{state | selected_team: team}
  end

  def toggle_team_field(%__MODULE__{selected_team: nil} = state, _field), do: state

  def toggle_team_field(%__MODULE__{selected_team: selected_team} = state, "being_edited") do
    selected_team =
      if selected_team.being_edited do
        %{selected_team | being_edited: false}
      else
        %{selected_team | being_edited: true, changeset: Core.Team.changeset(selected_team, %{})}
      end

    %{state | selected_team: selected_team}
  end

  def update_team_name(%__MODULE__{selected_team: selected_team} = state, %{"name" => name}) do
    case Core.update_team_name(selected_team, name) do
      {:ok, struct} -> replace_team(state, struct)
      {:error, changeset} -> replace_team(state, changeset)
    end
  end

  defp replace_team(%__MODULE__{selected_team: selected_team} = state, %Core.Team{} = team) do
    team = %{team | being_edited: false, changeset: nil}

    teams =
      state.teams
      |> Enum.map(fn t -> if t.id == selected_team.id, do: team, else: t end)
      |> Enum.sort(fn (a, b) -> a.name <= b.name end)

    %{state | teams: teams, selected_team: team}
  end

  defp replace_team(%__MODULE__{selected_team: selected_team} = state, %Ecto.Changeset{} = cs) do
    %{state | selected_team: %{selected_team | changeset: cs}}
  end
end
