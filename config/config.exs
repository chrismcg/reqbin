# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :reqbin,
  namespace: ReqBin,
  ecto_repos: [ReqBin.Repo]

# Configures the endpoint
config :reqbin, ReqBinWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a3WOv25AdZ/urWiI6ymMRWWYljoKWxaZzX+57E3vSOUjqm0f1tillTgv8uPYvxg8",
  render_errors: [view: ReqBinWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ReqBin.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "oJI1dh6eH2CMxh8Y4WEHJHhhMI3fZR+1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
