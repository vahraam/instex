defmodule Instex.Struct.V22_0.Entry.Change do
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
    :standby,
  ]

  embedded_schema do
    field :field, Ecto.Enum, values: @change_types
    embeds_one :value, Instex.Struct.V22_0.Entry.Change.Value
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:field])
    |> handle_value()
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :messages}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_messages/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :standby}} = ch) do
    ch
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :messaging_seen}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_messaging_seen/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :messaging_referral}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_messaging_referral/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :messaging_postbacks}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_messaging_postbacks/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :messaging_optins}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_messaging_optins/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :messaging_handover}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_messaging_handover/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :message_reactions}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_message_reactions/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :live_comments}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_live_comments/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: :comments}} = ch) do
    cast_embed(ch, :value, with: &Instex.Struct.V22_0.Entry.Change.Value.changeset_comments/2)
  end

  def handle_value(%Ecto.Changeset{changes: %{field: _}} = ch) do

    ch
  end

end
