defmodule Instex.Struct.V22_0.API.IceBreakerRequest do
  use Instex.Struct.V22_0.Schema

  @derive {Jason.Encoder, only: [:ice_breakers]}

  embedded_schema do
    embeds_many :ice_breakers, IceBreaker, primary_key: false do
      @derive {Jason.Encoder, only: [:locale, :call_to_actions]}
      field :locale, Ecto.Enum, values: [:default]
      embeds_many :call_to_actions, CallToAction, primary_key: false do
        @derive {Jason.Encoder, only: [:question, :payload]}
        field :question, :string
        field :payload, :string
      end
    end
  end

end
