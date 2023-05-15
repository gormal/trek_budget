# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :trek_budget,
  ecto_repos: [TrekBudget.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :trek_budget, TrekBudgetWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: TrekBudgetWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TrekBudget.PubSub,
  live_view: [signing_salt: "ud7qbBd/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: TrekBudget.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

config :trek_budget, TrekBudgetWeb.Auth.Guardian,
  issuer: "trek_budget",
  secret_key: "T5qCnj9AkKWNSrbiJzcRrI5esytlToTdv7RWd0UYDIHvNANbKLrLr+HJRIwd1ptv"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
