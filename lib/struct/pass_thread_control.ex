defmodule Instex.Struct.PassThreadControl do
  use Instex.Struct.Schema

  embedded_schema do
    field :previous_owner_app_id, :integer
    field :new_owner_app_id, :integer
    field :metadata, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:previous_owner_app_id, :new_owner_app_id, :metadata])
  end
end
