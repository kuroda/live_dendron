defmodule LiveDendron.TeamEditor do
  alias LiveDendron.Core

  defstruct team: nil, activated: false, changeset: nil

  @doc false
  def construct(team) do
    %__MODULE__{
      team: team
    }
  end

  @doc false
  def toggle_activated(%__MODULE__{activated: false} = editor) do
    %{editor | activated: true, changeset: Core.Team.changeset(editor.team, %{})}
  end

  def toggle_activated(%__MODULE__{activated: true} = editor) do
    %{editor | activated: false, changeset: nil}
  end

  @doc false
  def update_team_name(%__MODULE__{} = editor, %{"name" => name} = _params) do
    cs = %{editor.changeset | valid?: true}
    Core.update_team_name(cs, name)
  end
end
