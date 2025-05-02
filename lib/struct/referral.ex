defmodule Instex.Struct.Referral do
  use Instex.Struct.Schema

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
