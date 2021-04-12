defmodule SpeedrunBlogengine.Repo do
  use Ecto.Repo,
    otp_app: :speedrun_blogengine,
    adapter: Ecto.Adapters.Postgres
end
