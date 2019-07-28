import LiveDendron.Repo
alias LiveDendron.Core
alias LiveDendron.Tree.Root
alias LiveDendron.Tree.Group
alias LiveDendron.Tree.Member

group1 = %Group{
  name: "Sales",
  subgroups: [
    %Group{
      name: "Corporate sales",
      members: [
        %Member{name: "Taro Yamada"},
        %Member{name: "Hanako Suzuki"}
      ]
    },
    %Group{
      name: "Retail sales",
      members: [
        %Member{name: "Jiro Takahashi"},
        %Member{name: "Keiko Sato"}
      ]
    }
  ]
}

group2 = %Group{
  name: "Tech",
  subgroups: [
    %Group{
      name: "Basic Research",
      members: [
        %Member{name: "Saburo Tanaka"}
      ]
    },
    %Group{
      name: "Robotics",
      members: [
        %Member{name: "Aiko Yamamoto"},
        %Member{name: "Jun Kobayashi"}
      ]
    }
  ]
}

root = %Root{
  groups: [group1, group2]
}

insert!(%Core.Team{
  name: "Alpha",
  organization_tree: :erlang.term_to_binary(root)
})
