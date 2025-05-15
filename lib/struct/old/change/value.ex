defmodule Instex.Struct.Old.Change.Value do
  use Instex.Struct.Old.Schema

  embedded_schema do
    embeds_one :message, Instex.Struct.Old.Message
    embeds_one :sender, Instex.Struct.Old.User
    embeds_one :recipient, Instex.Struct.Old.User
    embeds_one :read, Instex.Struct.Old.Message
    embeds_one :referral, Instex.Struct.Old.Referral
    embeds_one :postback, Instex.Struct.Old.Postback
    embeds_one :optin, Instex.Struct.Old.Optin
    embeds_one :pass_thread_control, Instex.Struct.Old.PassThreadControl
    embeds_one :reaction, Instex.Struct.Old.Reaction
    field :id, :integer
    field :text, :string
    embeds_one :from, Instex.Struct.Old.User
    embeds_one :media, Instex.Struct.Old.Media
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
