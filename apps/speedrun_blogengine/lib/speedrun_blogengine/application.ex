defmodule SpeedrunBlogengine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SpeedrunBlogengine.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SpeedrunBlogengine.PubSub}
      # Start a worker by calling: SpeedrunBlogengine.Worker.start_link(arg)
      # {SpeedrunBlogengine.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: SpeedrunBlogengine.Supervisor)
  end
end
