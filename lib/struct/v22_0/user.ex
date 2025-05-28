defmodule Instex.Struct.V22_0.User do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field(:id, :string)
    field(:username, :string)
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :username])
  end
end
