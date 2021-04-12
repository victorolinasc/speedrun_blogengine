defmodule SpeedrunBlogengine.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      SpeedrunBlogengine.Repo
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: SpeedrunBlogengine.Supervisor)
  end
end
