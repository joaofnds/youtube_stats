# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :youtube_stats,
  ecto_repos: [YoutubeStats.Repo]

# Configures the endpoint
config :youtube_stats, YoutubeStatsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Zr/6hBb0Z41qAuADKdvjSeTBfh/dCcABCBGV41bzLxW6OJzvx5j7+68fzPs7u9Ma",
  render_errors: [view: YoutubeStatsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: YoutubeStats.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
