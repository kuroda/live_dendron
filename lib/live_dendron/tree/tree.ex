defmodule LiveDendron.Tree do
  alias LiveDendron.TeamEditor
  alias LiveDendron.TreeEditor

  @doc false
  def toggle_group_expanded(%TeamEditor{} = editor, uuid) do
    tree_editor = expand_or_shrink(editor.tree_editor, uuid)
    %{editor | tree_editor: tree_editor}
  end

  defp expand_or_shrink(%TreeEditor.Root{uuid: u} = root, uuid) when u == uuid do
    %{root | expanded: not root.expanded}
  end

  defp expand_or_shrink(%TreeEditor.Root{} = root, uuid) do
    groups = Enum.map(root.groups, fn g -> expand_or_shrink(g, uuid) end)
    %{root | groups: groups}
  end

  defp expand_or_shrink(%TreeEditor.Group{uuid: u} = group, uuid) when u == uuid do
    %{group | expanded: not group.expanded}
  end

  defp expand_or_shrink(%TreeEditor.Group{} = group, uuid) do
    subgroups = Enum.map(group.subgroups, fn g -> expand_or_shrink(g, uuid) end)
    %{group | subgroups: subgroups}
  end
end
