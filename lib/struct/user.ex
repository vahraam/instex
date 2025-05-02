defmodule Instex.Struct.User do
  use Instex.Struct.Schema

  embedded_schema do
    field :id, :integer
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id])
  end

end
