# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :speedrun_blogengine,
  ecto_repos: [SpeedrunBlogengine.Repo]

config :speedrun_blogengine_web,
  ecto_repos: [SpeedrunBlogengine.Repo],
  generators: [context_app: :speedrun_blogengine, binary_id: true]

# Configures the endpoint
config :speedrun_blogengine_web, SpeedrunBlogengineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZkzpzD2S5NJlJy73er/Fd3OSzJy5cvHmjH1JWKD4UooX8P6t+PdhwYtPE2VQEgj6",
  render_errors: [view: SpeedrunBlogengineWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SpeedrunBlogengine.PubSub,
  live_view: [signing_salt: "OoM2tPvn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
