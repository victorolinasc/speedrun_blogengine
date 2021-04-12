defmodule SpeedrunBlogengineWeb.InputValidation do
  @moduledoc """
  Validates a given map of params with the given schema. 
  """

  @doc """
  Apply the changeset function of the given module passing params.

  When successful, it returns {:ok, schema} and an instance of the the given
  schema.

  When validation fails, it returns {:error, changeset}.
  """
  def cast_and_apply(params, module) do
    case module.changeset(params) do
      %{valid?: true} = changeset ->
        {:ok, Ecto.Changeset.apply_changes(changeset)}

      %{valid?: false} = changeset ->
        {:error, changeset}
    end
  end
end
