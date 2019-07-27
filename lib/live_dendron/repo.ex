defmodule LiveDendron.Repo do
  use Ecto.Repo,
    otp_app: :live_dendron,
    adapter: Ecto.Adapters.Postgres
end
