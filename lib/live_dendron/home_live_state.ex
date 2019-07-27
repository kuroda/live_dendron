defmodule LiveDendron.HomeLiveState do
  alias LiveDendron.Core

  defstruct teams: [], selected_team: :none

  def construct() do
    %__MODULE__{
      teams: Core.list_teams()
    }
  end

  def select_team(%__MODULE__{} = state, "") do
    %{state | selected_team: :none}
  end

  def select_team(%__MODULE__{} = state, id) do
    team = Enum.find(state.teams, fn t -> t.id == id end)
    %{state | selected_team: team}
  end
end
