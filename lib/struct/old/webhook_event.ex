defmodule Instex.Struct.Old.WebhookEvent do
  use Instex.Struct.Old.Schema

  embedded_schema do
    field :object, Ecto.Enum, values: [:nil, :instagram]
    embeds_many :entry, Instex.Struct.Old.Entry
  end

  def builder(map) do
    %__MODULE__{}
    |> cast(map, [:object])
    |> cast_embed(:entry)
    |> apply_action(:build)
  end
end
