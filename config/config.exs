import Config

config :speedrun_blogengine,
  ecto_repos: [SpeedrunBlogengine.Repo]

config :speedrun_blogengine_web,
  ecto_repos: [SpeedrunBlogengine.Repo],
  generators: [context_app: :speedrun_blogengine, binary_id: true]

config :speedrun_blogengine_web, SpeedrunBlogengineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZkzpzD2S5NJlJy73er/Fd3OSzJy5cvHmjH1JWKD4UooX8P6t+PdhwYtPE2VQEgj6",
  render_errors: [view: SpeedrunBlogengineWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SpeedrunBlogengine.PubSub,
  live_view: [signing_salt: "OoM2tPvn"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
