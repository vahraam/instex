defmodule Instex.Struct.V22_0.Entry.Messaging.Message do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field :mid, :string
    field :text, :string
    embeds_one :reply_to, Instex.Struct.V22_0.Entry.Messaging.Message
    embeds_many :attachments, Instex.Struct.V22_0.Entry.Messaging.Message.Attachment
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:mid, :text])
    |> cast_embed(:attachments)
    |> cast_embed(:reply_to)
  end

end
