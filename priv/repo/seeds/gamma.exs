import LiveDendron.Repo
alias LiveDendron.Core
alias LiveDendron.Tree.Root
alias LiveDendron.Tree.Member

root = %Root{
  members: [
    %Member{name: "Alice"},
    %Member{name: "Bob"},
    %Member{name: "Carol"}
  ]
}

insert!(%Core.Team{
  name: "Gamma",
  organization_tree: :erlang.term_to_binary(root)
})
