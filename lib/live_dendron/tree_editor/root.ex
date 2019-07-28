defmodule LiveDendron.TreeEditor.Root do
  alias LiveDendron.Tree
  alias LiveDendron.TreeEditor

  defstruct groups: [], members: [], expanded: false, changeset: nil, uuid: nil

  def equip(%Tree.Root{} = root) do
    %__MODULE__{
      groups: Enum.map(root.groups, fn g -> TreeEditor.Group.equip(g) end),
      members: Enum.map(root.members, fn m -> TreeEditor.Member.equip(m) end),
      uuid: Ecto.UUID.generate()
    }
  end

  def unequip(%__MODULE__{} = root) do
    %Tree.Root{
      groups: Enum.map(root.groups, fn g -> TreeEditor.Group.unequip(g) end),
      members: Enum.map(root.members, fn m -> TreeEditor.Member.unequip(m) end)
    }
  end
end
