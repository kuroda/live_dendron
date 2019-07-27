defmodule LiveDendron.Core do
  import Ecto.Query, warn: false
  alias LiveDendron.Repo
  alias LiveDendron.Core

  @doc false
  def list_teams() do
    from(t in Core.Team, order_by: t.name)
    |> Repo.all()
  end

  @doc false
  def fetch_team(id) do
    Repo.get!(Core.Team, id)
  end
end
