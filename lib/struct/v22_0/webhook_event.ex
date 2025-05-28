defmodule Instex.Struct.V22_0.WebhookEntry do
  use Instex.Struct.V22_0.Schema

  embedded_schema do
    field(:object, Ecto.Enum, values: [nil, :instagram])
    embeds_many(:entry, Instex.Struct.V22_0.Entry)
  end

  def builder(map) do
    %__MODULE__{}
    |> cast(map, [:object])
    |> cast_embed(:entry)
    |> apply_action!(:build)
  end
end
