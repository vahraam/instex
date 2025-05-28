defmodule Instex.Struct.V22_0.Entry.Messaging.Referral do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field(:ref, :string)
    field(:source, Ecto.Enum, values: [:SHORTLINK])
    field(:type, Ecto.Enum, values: [:OPEN_THREAD])
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:ref, :source, :type])
  end
end
