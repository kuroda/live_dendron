defmodule LiveDendron.TreeEditor.TreeEditorTest do
  use ExUnit.Case
  use LiveDendron.DataCase

  import LiveDendron.Repo
  alias LiveDendron.Core
  alias LiveDendron.TeamEditor
  alias LiveDendron.Tree.Root
  alias LiveDendron.Tree.Group
  alias LiveDendron.Tree.Member
  alias LiveDendron.TreeEditor

  def group1() do
    %Group{
      name: "Sales",
      subgroups: [
        %Group{
          name: "Corporate sales",
          members: [
            %Member{name: "Alice"},
            %Member{name: "Bob"}
          ]
        },
        %Group{
          name: "Retail sales",
          members: [
            %Member{name: "Carol"}
          ]
        }
      ]
    }
  end

  def group2() do
    %Group{
      name: "Tech",
      members: [
        %Member{name: "David"}
      ]
    }
  end

  def create_team() do
    root = %Root{
      groups: [group1(), group2()]
    }

    insert!(%Core.Team{
      name: "Omega",
      organization_tree: :erlang.term_to_binary(root)
    })
  end

  def find_by_name(enumerable, name) do
    Enum.find(enumerable, fn e -> e.name == name end)
  end

  describe "add_member/2" do
    test "create a new member node under the group Tech" do
      team = create_team()
      editor = TeamEditor.construct(team)
      group = editor.tree_editor.groups |> find_by_name("Tech")

      editor = TreeEditor.add_member(editor, group.uuid)

      group = editor.tree_editor.groups |> find_by_name("Tech")
      assert length(group.members) == 2
    end

    test "create a new member node under the subgroup Corporate sales" do
      team = create_team()
      editor = TeamEditor.construct(team)
      group = editor.tree_editor.groups |> find_by_name("Sales")
      subgroup = group.subgroups |> find_by_name("Corporate sales")

      editor = TreeEditor.add_member(editor, subgroup.uuid)

      group = editor.tree_editor.groups |> find_by_name("Sales")
      subgroup = group.subgroups |> find_by_name("Corporate sales")
      assert length(subgroup.members) == 3
    end
  end

  describe "edit_node/2" do
    test "a newly created member with empty name should be deleted" do
      team = create_team()
      editor = TeamEditor.construct(team)
      group = editor.tree_editor.groups |> find_by_name("Tech")
      editor = TreeEditor.add_member(editor, group.uuid)

      editor = TreeEditor.edit_node(editor, "")

      group = editor.tree_editor.groups |> find_by_name("Tech")
      assert length(group.members) == 1
    end

    test "a newly created group with empty name should be deleted" do
      team = create_team()
      editor = TeamEditor.construct(team)
      group = editor.tree_editor.groups |> find_by_name("Tech")
      editor = TreeEditor.add_group(editor, group.uuid)

      editor = TreeEditor.edit_node(editor, "")

      group = editor.tree_editor.groups |> find_by_name("Tech")
      assert length(group.subgroups) == 0
    end
  end
end
