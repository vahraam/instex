defmodule Instex.Struct.Old.Media do
  use Instex.Struct.Old.Schema

  embedded_schema do
    field :id, :integer
    field :media_product_type, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :media_product_type])
  end
end
