import Config

config :speedrun_blogengine, SpeedrunBlogengine.Repo,
  username: "postgres",
  password: "postgres",
  database: "speedrun_blogengine_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :speedrun_blogengine_web, SpeedrunBlogengineWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
