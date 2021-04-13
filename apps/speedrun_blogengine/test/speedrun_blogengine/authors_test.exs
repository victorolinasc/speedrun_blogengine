defmodule SpeedrunBlogengine.AuthorsTest do
  use SpeedrunBlogengine.DataCase

  alias SpeedrunBlogengine.Authors
  alias SpeedrunBlogengine.Authors.Inputs
  alias SpeedrunBlogengine.Authors.Schemas.Author

  # Triple A: Arrange, Act and Assert

  # ALWAYS make a test fail once

  test "fail if email is already taken" do
  end

  test "successfully create an author with valid input" do
    email = "#{Ecto.UUID.generate()}@email.com"

    assert {:ok, author} =
             Authors.create_new_author(%Inputs.Create{
               name: "random name",
               email: email,
               email_confirmation: email
             })

    assert author.name == "random name"
    assert author.email == email

    query = from(a in Author, where: a.email == ^email)

    assert [^author] = Repo.all(query)
  end

  test "yields error when email has already been taken" do
    email = "taken@email.com"

    Authors.create_new_author(%Inputs.Create{
      name: "Some Author Name",
      email: email,
      email_confirmation: email
    })

    assert {:error, :email_conflict} =
             Authors.create_new_author(%Inputs.Create{
               name: "Some author name",
               email: email,
               email_confirmation: email
             })

    assert 1 = Repo.all(Author) |> length()
  end
end
