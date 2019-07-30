defmodule LiveDendron.TreeEditor do
  alias LiveDendron.Core
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
  def update_node_name(%TeamEditor{} = editor, uuid, params) do
    tree_editor = do_update_node_name(editor.tree_editor, uuid, params)
    editor = %{editor | tree_editor: tree_editor}

    if being_edited?(tree_editor) do
      :error
    else
      data =
        tree_editor
        |> TreeEditor.Root.unequip()
        |> :erlang.term_to_binary()

      {:ok, _team} = Core.update_team_organization_tree(editor.team, data)
      {:ok, editor}
    end
  end

  defp do_update_node_name(%TreeEditor.Root{} = root, uuid, params) do
    groups = Enum.map(root.groups, fn g -> do_update_node_name(g, uuid, params) end)
    members = Enum.map(root.members, fn m -> do_update_node_name(m, uuid, params) end)
    %{root | groups: groups, members: members}
  end

  @name_holder_modules [TreeEditor.Group, TreeEditor.Member]
  defp do_update_node_name(%mod{uuid: u} = group, uuid, params)
       when u == uuid and mod in @name_holder_modules do
    cs = TreeEditor.NameHolder.changeset(group.changeset, params)

    if cs.valid? do
      name_holder = Ecto.Changeset.apply_changes(cs)
      %{group | name: name_holder.name, changeset: nil}
    else
      %{group | changeset: cs}
    end
  end

  defp do_update_node_name(%TreeEditor.Group{} = group, uuid, params) do
    subgroups = Enum.map(group.subgroups, fn g -> do_update_node_name(g, uuid, params) end)
    members = Enum.map(group.members, fn m -> do_update_node_name(m, uuid, params) end)
    %{group | subgroups: subgroups, members: members, changeset: nil}
  end

  defp do_update_node_name(%TreeEditor.Member{} = member, _uuid, _params) do
    %{member | changeset: nil}
  end

  defp being_edited?(%TreeEditor.Root{} = root) do
    Enum.all?(root.groups ++ root.members, fn node -> being_edited?(node) end)
  end

  defp being_edited?(%TreeEditor.Group{changeset: nil} = group) do
    Enum.all?(group.subgroups ++ group.members, fn node -> being_edited?(node) end)
  end

  defp being_edited?(%TreeEditor.Group{} = _group), do: true
  defp being_edited?(%TreeEditor.Member{changeset: nil} = _member), do: false
  defp being_edited?(%TreeEditor.Member{} = _member), do: true
end
