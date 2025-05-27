defmodule Instex.Struct.V22_0.Entry.Messaging.Message do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field :mid, :string
    field :text, :string
    field :is_deleted, :boolean
    embeds_one :quick_reply, Instex.Struct.V22_0.Entry.Messaging.Message.QuickReply
    embeds_one :reply_to, Instex.Struct.V22_0.Entry.Messaging.Message
    embeds_many :attachments, Instex.Struct.V22_0.Entry.Messaging.Message.Attachment
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:mid, :text])
    |> cast_embed(:attachments)
    |> cast_embed(:reply_to)
    |> cast_embed(:quick_reply)
  end

end
