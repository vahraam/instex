defmodule Instex.Struct.V22_0.Entry.Messaging.Message.Attachment do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field(:type, Ecto.Enum, values: [:share, :video, :image, :story_mention, :template])
    embeds_one(:payload, Instex.Struct.V22_0.Entry.Messaging.Message.Attachment.Payload)
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:type])
    |> cast_embed(:payload)
  end
end
