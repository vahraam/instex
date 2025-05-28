defmodule Instex.Struct.V22_0.Entry.Messaging.Message.QuickReply do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field(:payload, :string)
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:payload])
  end
end
