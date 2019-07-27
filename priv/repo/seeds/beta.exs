import LiveDendron.Repo
alias LiveDendron.Core

tree = []

insert!(%Core.Team{
  name: "Beta",
  organization_tree: :erlang.term_to_binary(tree)
})
