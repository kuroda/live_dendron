import LiveDendron.Repo
alias LiveDendron.Core

Core.Team |> delete_all()

filenames = ~w(
  alpha
  beta
  gamma
)

Enum.map(filenames, fn filename ->
  Code.eval_file("./priv/repo/seeds/#{filename}.exs")
end)
