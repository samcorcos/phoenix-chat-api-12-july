# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :phoenix_chat, PhoenixChat.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "uNLxLrP/39DXUeSqrtUBGhgOUE51jK54jKofwcZMoO3UwcCKcdL3SXWuOB+I8Id9",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: PhoenixChat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [callback_methods: ["POST"]]}
  ]

config :guardian, Guardian,
  issuer: "PhoenixChat",
  ttl: {30, :days},
  secret_key: "uw/27wdrIquPn2fktwfJg9tg8qOl5ysTPCFjISw1TCCaLlfWgRUAea1SuWcfERzX",
  serializer: PhoenixChat.GuardianSerializer,
  permissions: %{default: [:read, :write]}
