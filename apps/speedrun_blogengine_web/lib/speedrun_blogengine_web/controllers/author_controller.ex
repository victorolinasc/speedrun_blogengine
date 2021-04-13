defmodule SpeedrunBlogengineWeb.AuthorController do
  @moduledoc """
  Actions related to the author resource.
  """
  use SpeedrunBlogengineWeb, :controller

  alias SpeedrunBlogengine.Authors
  alias SpeedrunBlogengine.Authors.Inputs

  alias SpeedrunBlogengineWeb.InputValidation

  # params = path_parameters + query_parameters + body
  def create(conn, params) do
    with {:ok, input} <- InputValidation.cast_and_apply(params, Inputs.Create),
         {:ok, author} <- Authors.create_new_author(input) do
      send_json(conn, 200, author)
    else
      {:error, %Ecto.Changeset{}} ->
        msg = %{type: "bad_input", description: "Invalid input"}
        send_json(conn, 400, msg)

      {:error, :email_conflict} ->
        msg = %{type: "conflict", description: "Email already taken"}
        send_json(conn, 412, msg)
    end
  end

  defp send_json(conn, status, body) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end
end
