defmodule LiveDendron.TreeEditor.Member do
  alias LiveDendron.Tree
  alias LiveDendron.TreeEditor

  defstruct name: "", in_trash: false, getting_destroyed: false, changeset: nil, uuid: nil

  @doc false
  def equip(%Tree.Member{} = member) do
    %__MODULE__{
      name: member.name,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc false
  def unequip(%__MODULE__{} = member) do
    %Tree.Member{
      name: member.name
    }
  end

  @doc false
  def build() do
    %__MODULE__{
      changeset: TreeEditor.NameHolder.build("New member"),
      uuid: Ecto.UUID.generate()
    }
  end
end
