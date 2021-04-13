defmodule SpeedrunBlogengine.Authors do
  @moduledoc """
  Domain public functions about the authors context.
  """

  alias SpeedrunBlogengine.Authors.Inputs
  alias SpeedrunBlogengine.Authors.Schemas.Author
  alias SpeedrunBlogengine.Repo

  require Logger

  @doc """
  Fetch an author from the database.
  """
  @spec fetch(Ecto.UUID.t()) :: {:ok, Author.t()} | {:error, :not_found}
  def fetch(author_id) do
    Logger.debug("Fetch author by id: #{inspect(author_id)}")

    case Repo.get(Author, author_id) do
      nil -> {:error, :not_found}
      author -> {:ok, author}
    end
  end

  @doc """
  Given a VALID changeset it attempts to insert a new author.

  It might fail due to email unique index and we transform that return
  into an error tuple.
  """
  @spec create_new_author(Inputs.Create.t()) ::
          {:ok, Author.t()} | {:error, Ecto.Changeset.t() | :email_conflict}
  def create_new_author(%Inputs.Create{} = input) do
    Logger.info("Inserting new author")

    params = %{name: input.name, email: input.email}

    with %{valid?: true} = changeset <- Author.changeset(params),
         {:ok, author} <- Repo.insert(changeset) do
      Logger.info("Author successfully inserted. Email: #{author.email}")
      {:ok, author}
    else
      %{valid?: false} = changeset ->
        Logger.error("Error while inserting new author. Error: #{inspect(changeset)}")
        {:error, changeset}
    end
  rescue
    Ecto.ConstraintError ->
      Logger.error("Email already taken")
      {:error, :email_conflict}
  end
end
