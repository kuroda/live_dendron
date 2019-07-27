import LiveDendron.Repo
alias LiveDendron.Core

tree = []

insert!(%Core.Team{
  name: "Gamma",
  organization_tree: :erlang.term_to_binary(tree)
})
