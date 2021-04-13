defmodule SpeedrunBlogengineWeb.AuthorControllerTest do
  use SpeedrunBlogengineWeb.ConnCase, async: true

  alias SpeedrunBlogengine.Authors.Schemas.Author
  alias SpeedrunBlogengine.Repo

  # Triple AAA: Arrange, Act and Assert

  describe "POST /api/authors" do
    test "fail with 400 when email_confirmation does NOT match email", ctx do
      input = %{"name" => "abc", "email" => "a@a.com", "email_confirmation" => "b@a.com"}

      assert ctx.conn
             |> post("/api/authors", input)
             |> json_response(400) == %{
               "description" => "Invalid input",
               "type" => "bad_input",
               "details" => %{
                 "email_and_confirmation" => "Email and confirmation must be the same"
               }
             }
    end

    test "fail with 400 when name is too small", ctx do
      input = %{"name" => "A", "email" => "a@a.com", "email_confirmation" => "a@a.com"}

      assert ctx.conn
             |> post("/api/authors", input)
             |> json_response(400) == %{
               "description" => "Invalid input",
               "type" => "bad_input",
               "details" => %{
                 "name" => "should be at least %{count} character(s)"
               }
             }
    end

    test "fail with 400 when email format is invalid", ctx do
      input = %{"name" => "Abc de D", "email" => "a@@a.com", "email_confirmation" => "a@a.com"}

      assert ctx.conn
             |> post("/api/authors", input)
             |> json_response(400) == %{
               "description" => "Invalid input",
               "type" => "bad_input",
               "details" => %{
                 "email" => "has invalid format"
               }
             }
    end

    test "fail with 400 when email_confirmation format is invalid", ctx do
      input = %{"name" => "Abc de D", "email" => "a@a.com", "email_confirmation" => "a@@a.com"}

      assert ctx.conn
             |> post("/api/authors", input)
             |> json_response(400) == %{
               "description" => "Invalid input",
               "type" => "bad_input",
               "details" => %{
                 "email_confirmation" => "has invalid format"
               }
             }
    end

    test "fail with 400 when required fields are missing", ctx do
      input = %{}

      assert ctx.conn
             |> post("/api/authors", input)
             |> json_response(400) == %{
               "description" => "Invalid input",
               "type" => "bad_input",
               "details" => %{
                 "email_confirmation" => "can't be blank",
                 "email" => "can't be blank",
                 "name" => "can't be blank"
               }
             }
    end

    @tag capture_log: true
    test "fail with 412 when email is already taken", ctx do
      email = "#{Ecto.UUID.generate()}@email.com"

      Repo.insert!(%Author{email: email})

      input = %{
        "name" => "Um Dois Três de Oliveira Quatro",
        "email" => email,
        "email_confirmation" => email
      }

      assert ctx.conn
             |> post("/api/authors", input)
             |> json_response(412) == %{
               "description" => "Email already taken",
               "type" => "conflict"
             }
    end
  end

  describe "GET /api/authors/:id" do
    test "fail if id is not an UUID", ctx do
      assert ctx.conn
             |> get("/api/authors/qualquercoisa")
             |> json_response(400) == %{
               "description" => "Not a proper UUID v4",
               "type" => "bad_input"
             }
    end

    test "fail if there are no authors with the given id", ctx do
      assert ctx.conn
             |> get("/api/authors/#{Ecto.UUID.generate()}")
             |> json_response(404) == %{
               "description" => "Author not found",
               "type" => "not_found"
             }
    end

    test "successfully show author details", ctx do
      author =
        Repo.insert!(%Author{email: "#{Ecto.UUID.generate()}@email.com", name: "Some name"})

      assert %{
               "email" => email,
               "id" => id,
               "inserted_at" => inserted_at,
               "name" => "Some name",
               "updated_at" => updated_at
             } =
               ctx.conn
               |> get("/api/authors/#{author.id}")
               |> json_response(200)

      assert email == author.email
      assert id == author.id
      assert inserted_at == NaiveDateTime.to_iso8601(author.inserted_at)
      assert updated_at == NaiveDateTime.to_iso8601(author.updated_at)
    end
  end
end
