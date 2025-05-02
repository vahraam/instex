defmodule Instex.Struct.Postback do
  use Instex.Struct.Schema


  embedded_schema do
    field :mid, :string
    field :title, :string
    field :payload, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:mid, :title, :payload])
  end
end
