import Mix.Config

config :app, AppWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "elixir-auth-google-demo.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

# Do not print debug messages in production
config :logger, level: :info
