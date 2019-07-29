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

  @doc false
  def edit_node(%TeamEditor{} = editor, uuid) do
    tree_editor = do_edit_node(editor.tree_editor, uuid)
    %{editor | tree_editor: tree_editor}
  end

  defp do_edit_node(%TreeEditor.Root{} = root, uuid) do
    groups = Enum.map(root.groups, fn g -> do_edit_node(g, uuid) end)
    members = Enum.map(root.members, fn m -> do_edit_node(m, uuid) end)
    %{root | groups: groups, members: members}
  end

  defp do_edit_node(%TreeEditor.Group{uuid: u} = group, uuid) when u == uuid do
    %{group | changeset: TreeEditor.NameHolder.build(group)}
  end

  defp do_edit_node(%TreeEditor.Group{} = group, uuid) do
    subgroups = Enum.map(group.subgroups, fn g -> do_edit_node(g, uuid) end)
    members = Enum.map(group.members, fn m -> do_edit_node(m, uuid) end)
    %{group | subgroups: subgroups, members: members, changeset: nil}
  end

  defp do_edit_node(%TreeEditor.Member{uuid: u} = member, uuid) when u == uuid do
    %{member | changeset: TreeEditor.NameHolder.build(member)}
  end

  defp do_edit_node(%TreeEditor.Member{} = member, _uuid) do
    %{member | changeset: nil}
  end

  @doc false
  def update_node_name(%TeamEditor{} = editor, _uuid, _params) do
    editor
  end
end
