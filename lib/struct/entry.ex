defmodule Instex.Struct.Entry do
  use Instex.Struct.Schema

  embedded_schema do
    field :id, :integer
    field :time, :integer
    embeds_many :changes, Instex.Struct.Change
  end


  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :time])
    |> cast_embed(:changes)
  end

end
