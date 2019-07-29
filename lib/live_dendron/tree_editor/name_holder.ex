defmodule LiveDendron.TreeEditor.NameHolder do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:name, :string)
  end

  @required_fields [:name]

  @doc false
  def changeset(cs, attrs) do
    cs
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  @doc false
  def build(struct) do
    cast(%__MODULE__{name: struct.name}, %{}, [])
  end
end
