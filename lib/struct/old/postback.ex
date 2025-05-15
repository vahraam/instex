defmodule Instex.Struct.Old.Postback do
  use Instex.Struct.Old.Schema


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
