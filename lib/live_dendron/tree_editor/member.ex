defmodule LiveDendron.TreeEditor.Member do
  alias LiveDendron.Tree

  defstruct name: "", changeset: nil, uuid: nil

  def equip(%Tree.Member{} = member) do
    %__MODULE__{
      name: member.name,
      uuid: Ecto.UUID.generate()
    }
  end

  def unequip(%__MODULE__{} = member) do
    %Tree.Member{
      name: member.name
    }
  end
end
