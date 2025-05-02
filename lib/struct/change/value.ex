defmodule Instex.Struct.Change.Value do
  use Instex.Struct.Schema

  embedded_schema do
    embeds_one :message, Instex.Struct.Message
    embeds_one :sender, Instex.Struct.User
    embeds_one :recipient, Instex.Struct.User
    field :timestamp, :integer
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast_embed(:message)
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
  end

end
