defmodule Instex.Struct.Old.Entry do
  use Instex.Struct.Old.Schema

  embedded_schema do
    field :id, :integer
    field :time, :integer
    embeds_many :changes, Instex.Struct.Old.Change
  end


  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :time])
    |> cast_embed(:changes)
  end

end
