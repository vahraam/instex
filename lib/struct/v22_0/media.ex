defmodule Instex.Struct.V22_0.Media do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field :id, :string
    field :media_product_type, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :media_product_type])
  end
end
