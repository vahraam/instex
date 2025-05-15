defmodule Instex.Struct.Old.Reaction do
  use Instex.Struct.Old.Schema

  embedded_schema do
    field :mid, :string
    field :action, :string
    field :reaction, :string
    field :emoji, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:mid, :action, :reaction, :emoji])
  end
end
