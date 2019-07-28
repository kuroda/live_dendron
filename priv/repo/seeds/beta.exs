import LiveDendron.Repo
alias LiveDendron.Core
alias LiveDendron.Tree.Root
alias LiveDendron.Tree.Group
alias LiveDendron.Tree.Member

root = %Root{
  groups: [
    %Group{
      name: "Basic Research",
      members: [
        %Member{name: "Sally Housecoat"},
        %Member{name: "Eddie Punch-Clock"}
      ]
    }
  ],
  members: [
    %Member{name: "John Doe"}
  ]
}

insert!(%Core.Team{
  name: "Beta",
  organization_tree: :erlang.term_to_binary(root)
})
