defmodule SpeedrunBlogengineWeb.Router do
  use SpeedrunBlogengineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SpeedrunBlogengineWeb do
    pipe_through :api

    # get "/posts", PostsController, :list
    # post "/posts", PostsController, :create
    # get "/posts/:id", PostsController, :show
  end
end
