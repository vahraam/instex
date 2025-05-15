defmodule Instex.Struct.Old.Referral do
  use Instex.Struct.Old.Schema

  embedded_schema do
    field :ref, :string
    field :source, :string
    field :type, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:ref, :source, :type])
  end
end
