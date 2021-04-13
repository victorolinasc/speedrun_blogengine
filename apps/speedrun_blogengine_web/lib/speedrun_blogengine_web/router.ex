defmodule SpeedrunBlogengineWeb.Router do
  use SpeedrunBlogengineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SpeedrunBlogengineWeb do
    pipe_through :api

    # Criar um author
    post "/authors", AuthorController, :create
    get "/authors/:id", AuthorController, :show
  end
end
