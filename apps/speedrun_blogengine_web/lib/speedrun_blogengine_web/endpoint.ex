defmodule SpeedrunBlogengineWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :speedrun_blogengine_web

  @session_options [
    store: :cookie,
    key: "_speedrun_blogengine_web_key",
    signing_salt: "cZP8ZuyZ"
  ]

  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :speedrun_blogengine_web
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug SpeedrunBlogengineWeb.Router
end
