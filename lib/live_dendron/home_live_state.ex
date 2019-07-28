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
        %{team | being_edited: not team.being_edited}
      else
        team
      end
    end)

    %{state | teams: teams}
  end
end
