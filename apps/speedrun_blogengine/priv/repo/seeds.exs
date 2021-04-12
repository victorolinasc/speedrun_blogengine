# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SpeedrunBlogengine.Repo.insert!(%SpeedrunBlogengine.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

SpeedrunBlogengine.Repo.insert!(
  %SpeedrunBlogengine.Authors.Schemas.Author{
    name: "Capitão",
    email: "some.capitao@email.com"
  },
  on_conflict: :nothing
)
