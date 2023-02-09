# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Mix.Config

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QIdzBUNCk43VMLdi0GWE3Ww9PBBdCjQbTxubMEWUXs6o9RV9OpQI+60y6dYcsfZv",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: App.PubSub,
  live_view: [signing_salt: "LSeW6t0x"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir_auth_google,
  httpoison_mock: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# https://gist.github.com/chrismccord/2ab350f154235ad4a4d0f4de6decba7b
# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
