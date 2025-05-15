defmodule Instex.Struct.Old.User do
  use Instex.Struct.Old.Schema

  embedded_schema do
    field :id, :string
    field :username, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :username])
  end

end
