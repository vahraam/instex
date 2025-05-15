defmodule Instex.Struct.V22_0.Entry.Change.Value do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    embeds_one :sender, Instex.Struct.V22_0.User
    embeds_one :recipient, Instex.Struct.V22_0.User
    field :id, :integer
    field :text, :string
    embeds_one :from, Instex.Struct.V22_0.User
    embeds_one :media, Instex.Struct.V22_0.Media
    field :parent_id, :integer
    field :timestamp, :integer
  end

  def changeset_messages(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast_embed(:message)
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
  end

  def changeset_standby(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast(attrs, [])
  end

  def changeset_messaging_seen(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast_embed(:read)
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
  end

  def changeset_messaging_referral(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast_embed(:referral)
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
  end

  def changeset_messaging_postbacks(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast_embed(:postback)
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
  end

   def changeset_messaging_optins(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast_embed(:optin)
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
   end

   def changeset_messaging_handover(schema, attrs) do
     schema
     |> cast(attrs, [:timestamp])
     |> cast_embed(:sender)
     |> cast_embed(:recipient)
     |> cast_embed(:pass_thread_control)
   end

   def changeset_message_reactions(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp])
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
    |> cast_embed(:reaction)
   end

   def changeset_live_comments(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp, :id, :text])
    |> cast_embed(:from)
    |> cast_embed(:media)
   end

   def changeset_comments(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp, :id, :text, :parent_id])
    |> cast_embed(:from)
    |> cast_embed(:media)
   end

end
