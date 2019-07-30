defmodule LiveDendron.TreeEditor.Group do
  alias LiveDendron.Tree
  alias LiveDendron.TreeEditor

  defstruct name: "",
            subgroups: [],
            members: [],
            expanded: false,
            in_trash: false,
            getting_destroyed: false,
            changeset: nil,
            uuid: nil

  @doc false
  def equip(%Tree.Group{} = group) do
    %__MODULE__{
      name: group.name,
      subgroups: Enum.map(group.subgroups, fn g -> equip(g) end),
      members: Enum.map(group.members, fn m -> TreeEditor.Member.equip(m) end),
      uuid: Ecto.UUID.generate()
    }
  end

  @doc false
  def unequip(%__MODULE__{} = group) do
    %Tree.Group{
      name: group.name,
      subgroups: Enum.map(group.subgroups, fn g -> unequip(g) end),
      members: Enum.map(group.members, fn m -> TreeEditor.Member.unequip(m) end)
    }
  end

  @doc false
  def build() do
    %__MODULE__{
      changeset: TreeEditor.NameHolder.build("New group"),
      uuid: Ecto.UUID.generate()
    }
  end
end
