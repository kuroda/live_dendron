defmodule LiveDendron.Repo.Migrations.CreateCoreTeams do
  use Ecto.Migration

  def change do
    create table(:core_teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :organization_tree, :binary

      timestamps()
    end

    create unique_index(:core_teams, :name)
  end
end
