defmodule Instex.Struct.V22_0.Entry.Messaging.Reaction do
  use Instex.Struct.V22_0.Schema

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
