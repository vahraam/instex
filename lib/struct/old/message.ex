defmodule Instex.Struct.Old.Message do
  use Instex.Struct.Old.Schema


  embedded_schema do
    field :mid, :string
    field :text, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:mid, :text])
  end

end
