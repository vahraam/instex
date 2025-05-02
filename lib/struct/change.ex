defmodule Instex.Struct.Change do
  use Instex.Struct.Schema


  embedded_schema do
    field :field, Ecto.Enum, values: [:nil, :messages]
    embeds_one :value, Instex.Struct.Change.Value
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:field])
    |> cast_embed(:value)
  end

end
