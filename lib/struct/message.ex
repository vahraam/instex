defmodule Instex.Struct.Message do
  use Instex.Struct.Schema


  embedded_schema do
    field :mid, :string
    field :text, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:mid, :text])
  end

end
