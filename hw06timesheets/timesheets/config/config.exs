# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :timesheets,
  ecto_repos: [Timesheets.Repo]

# Configures the endpoint
config :timesheets, TimesheetsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iqJlcqSzjWxn3VohFB6X8QetPv+N6i2Nu5V5DYpAyVH0QfKS4GpbtmIY7FAC0s1z",
  render_errors: [view: TimesheetsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Timesheets.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
