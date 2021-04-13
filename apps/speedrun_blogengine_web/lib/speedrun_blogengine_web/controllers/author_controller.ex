defmodule SpeedrunBlogengineWeb.AuthorController do
  @moduledoc """
  Actions related to the author resource.
  """
  use SpeedrunBlogengineWeb, :controller

  alias SpeedrunBlogengine.Authors
  alias SpeedrunBlogengine.Authors.Inputs

  alias SpeedrunBlogengineWeb.InputValidation

  @doc """
  Fetch a single author details.
  """
  def show(conn, %{"id" => author_id}) do
    with {:uuid, {:ok, _}} <- {:uuid, Ecto.UUID.cast(author_id)},
         {:ok, author} <- Authors.fetch(author_id) do
      send_json(conn, 200, author)
    else
      {:uuid, :error} ->
        send_json(conn, 400, %{type: "bad_input", description: "Not a proper UUID v4"})

      {:error, :not_found} ->
        send_json(conn, 404, %{type: "not_found", description: "Author not found"})
    end
  end

  @doc """
  Create author action.
  """
  def create(conn, params) do
    with {:ok, input} <- InputValidation.cast_and_apply(params, Inputs.Create),
         {:ok, author} <- Authors.create_new_author(input) do
      send_json(conn, 200, author)
    else
      {:error, %Ecto.Changeset{errors: errors}} ->
        msg = %{
          type: "bad_input",
          description: "Invalid input",
          details: changeset_errors_to_details(errors)
        }

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

  defp changeset_errors_to_details(errors) do
    errors
    |> Enum.map(fn {key, {message, _opts}} -> {key, message} end)
    |> Map.new()
  end
end
