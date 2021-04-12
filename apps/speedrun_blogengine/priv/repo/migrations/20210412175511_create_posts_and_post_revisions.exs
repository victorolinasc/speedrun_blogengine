defmodule SpeedrunBlogengine.Repo.Migrations.CreatePostsAndPostRevisions do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :author_id, references(:authors, type: :uuid)

      timestamps()
    end

    create index(:posts, [:author_id])

    create table(:post_revisions, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :post_id, references(:posts, type: :uuid)
      add :title, :string
      add :contents, :text

      timestamps(updated_at: false)
    end

    create index(:post_revisions, [:post_id])
  end
end
