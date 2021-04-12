defmodule SpeedrunBlogengine.Repo.Migrations.CreateAuthor do
  use Ecto.Migration

  def change do
    create table(:authors, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:authors, [:email])
  end
end
