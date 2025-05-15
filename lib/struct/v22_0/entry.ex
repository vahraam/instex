defmodule Instex.Struct.V22_0.Entry do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field :id, :integer
    field :time, :integer
    embeds_many :changes, Instex.Struct.V22_0.Entry.Change
    embeds_many :messaging, Instex.Struct.V22_0.Entry.Messaging
  end


  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :time])
    |> cast_embed(:messaging)
    |> cast_embed(:changes)
  end

end
