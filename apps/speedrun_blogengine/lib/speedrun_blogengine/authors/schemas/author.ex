defmodule SpeedrunBlogengine.Authors.Schemas.Author do
  @moduledoc """
  The author of a post.
  """
  use Ecto.Schema

  import Ecto.Changeset

  @required [:name, :email]
  @optional []

  @derive {Jason.Encoder, except: [:__meta__]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "authors" do
    field :name, :string
    field :email, :string

    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+\-+']+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,4}$/)
  end
end
