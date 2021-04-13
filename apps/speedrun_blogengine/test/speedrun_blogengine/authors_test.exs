defmodule SpeedrunBlogengine.AuthorsTest do
  use SpeedrunBlogengine.DataCase, async: true

  alias SpeedrunBlogengine.Authors
  alias SpeedrunBlogengine.Authors.Inputs
  alias SpeedrunBlogengine.Authors.Schemas.Author

  # Triple A: Arrange, Act and Assert
  # ALWAYS make a test fail once

  describe "create_new_author/1" do
    @tag capture_log: true
    test "fail if email is already taken" do
      # 1. Arrange
      email = "taken@email.com"
      Repo.insert!(%Author{email: email})

      # 2. Act and 3. Assert
      assert {:error, :email_conflict} ==
               Authors.create_new_author(%Inputs.Create{name: "abc", email: email})
    end

    test "successfully create an author with valid input" do
      email = "#{Ecto.UUID.generate()}@email.com"

      assert {:ok, author} =
               Authors.create_new_author(%Inputs.Create{name: "random name", email: email})

      assert author.name == "random name"
      assert author.email == email

      query = from(a in Author, where: a.email == ^email)

      assert [^author] = Repo.all(query)
    end
  end
end
