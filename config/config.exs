# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_dendron,
  ecto_repos: [LiveDendron.Repo]

# Configures the endpoint
config :live_dendron, LiveDendronWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cpEwOwauUHjk3gHMRO6fmxhDK5lLvIWtdbRu6+rAnmqb2UAwl6qHHSCGXW/rLcRy",
  render_errors: [view: LiveDendronWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: LiveDendron.PubSub,
  live_view: [
    signing_salt: "CSOuW9cBIOIRzBAW3N0iFrsN/ITixF+/"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
