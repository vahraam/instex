defmodule Instex.Struct.WebhookEvent do
  use Instex.Struct.Schema

  embedded_schema do
    field :object, Ecto.Enum, values: [:nil, :instagram]
    embeds_many :entry, Instex.Struct.Entry
  end

  def builder(map) do
    %__MODULE__{}
    |> cast(map, [:object])
    |> cast_embed(:entry)
    |> apply_action(:build)
  end
end
