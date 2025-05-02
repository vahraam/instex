defmodule Instex.Struct.Media do
  use Instex.Struct.Schema

  embedded_schema do
    field :id, :integer
    field :media_product_type, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :media_product_type])
  end
end
