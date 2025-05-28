defmodule Instex.Struct.V22_0.Entry.Messaging do
  use Instex.Struct.V22_0.Schema

  @change_types [
    :comments,
    :live_comments,
    :message_reactions,
    :messages,
    :messaging_handover,
    :messaging_optins,
    :messaging_postbacks,
    :messaging_referral,
    :messaging_seen,
    :standby
  ]

  embedded_schema do
    field(:type, Ecto.Enum, values: @change_types)
    field(:field, :string)
    embeds_one(:message, Instex.Struct.V22_0.Entry.Messaging.Message)
    embeds_one(:sender, Instex.Struct.V22_0.User)
    embeds_one(:recipient, Instex.Struct.V22_0.User)
    embeds_one(:read, Instex.Struct.V22_0.Entry.Messaging.Message)
    embeds_one(:referral, Instex.Struct.V22_0.Entry.Messaging.Referral)
    embeds_one(:postback, Instex.Struct.V22_0.Entry.Messaging.Postback)
    embeds_one(:reaction, Instex.Struct.V22_0.Entry.Messaging.Reaction)
    field(:id, :string)
    field(:text, :string)
    embeds_one(:from, Instex.Struct.V22_0.User)
    embeds_one(:media, Instex.Struct.V22_0.Media)
    field(:mid, :string)
    field(:parent_id, :integer)
    field(:timestamp, :integer)
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:timestamp, :id, :text, :parent_id, :text, :mid])
    |> cast_embed(:message)
    |> cast_embed(:sender)
    |> cast_embed(:recipient)
    |> cast_embed(:read)
    |> cast_embed(:referral)
    |> cast_embed(:postback)
    |> cast_embed(:reaction)
    |> cast_embed(:from)
    |> cast_embed(:media)
    |> put_type()
  end

  defp put_type(%Ecto.Changeset{changes: %{reaction: %Ecto.Changeset{}}} = changeset) do
    changeset
    |> put_change(:type, :message_reactions)
  end

  defp put_type(%Ecto.Changeset{changes: %{message: %Ecto.Changeset{}}} = changeset) do
    changeset
    |> put_change(:type, :messages)
  end

  defp put_type(%Ecto.Changeset{changes: %{postback: %Ecto.Changeset{}}} = changeset) do
    changeset
    |> put_change(:type, :messaging_postbacks)
  end

  defp put_type(%Ecto.Changeset{changes: %{read: %Ecto.Changeset{}}} = changeset) do
    changeset
    |> put_change(:type, :messaging_seen)
  end

  defp put_type(%Ecto.Changeset{changes: %{referral: %Ecto.Changeset{}}} = changeset) do
    changeset
    |> put_change(:type, :messaging_referral)
  end
end
