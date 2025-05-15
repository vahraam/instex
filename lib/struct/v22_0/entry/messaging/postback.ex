defmodule Instex.Struct.V22_0.Entry.Messaging.Postback do
  use Instex.Struct.V22_0.Schema


  embedded_schema do
    field :mid, :string
    field :title, :string
    field :payload, :string
    embeds_one :referral, Instex.Struct.V22_0.Entry.Messaging.Referral
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:mid, :title, :payload])
    |> cast_embed(:referral)
  end
end
