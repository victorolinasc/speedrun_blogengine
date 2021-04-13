defmodule SpeedrunBlogengine.Authors.Inputs.Create do
  @moduledoc """
  Input data for calling insert_new_author/1.
  """
  use Ecto.Schema

  import Ecto.Changeset
  import SpeedrunBlogengine.Changesets

  @required [:name, :email, :email_confirmation]
  @optional []

  @primary_key false
  embedded_schema do
    field :name, :string
    field :email, :string

    field :email_confirmation, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_email(:email)
    |> validate_email(:email_confirmation)
    |> validate_fields([:email, :email_confirmation], fn changes, changeset ->
      if changes[:email] == changes[:email_confirmation] do
        changeset
      else
        add_error(changeset, :email_and_confirmation, "Email and confirmation must be the same")
      end
    end)
  end
end
