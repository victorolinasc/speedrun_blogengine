defmodule SpeedrunBlogengineWeb.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      SpeedrunBlogengineWeb.Telemetry,
      SpeedrunBlogengineWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: SpeedrunBlogengineWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    SpeedrunBlogengineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
