# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :prototype,
  ecto_repos: [Prototype.Repo]

#config :account_service, ecto_repos: [AccountService.Repo]

# Configures the endpoint
config :prototype, PrototypeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8fjiNjJ4TWFqZdScD3mxaykRlV5VMoQwTYxpS8Bjmptbwkfr/TD5jpyn0PLMuFZn",
  render_errors: [view: PrototypeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Prototype.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
