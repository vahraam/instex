defmodule Instex.Struct.V22_0.Entry.Messaging.Message.Attachment.Payload do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field(:url, :string)
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:url])
  end
end
