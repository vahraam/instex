defmodule Instex.Struct.V22_0.API.PersistentMenuRequest do
  use Instex.Struct.V22_0.Schema

  @derive {Jason.Encoder, only: [:persistent_menu]}

  embedded_schema do
    embeds_many :persistent_menu, PersistentMenu, primary_key: false do
      @derive {Jason.Encoder, only: [:locale, :call_to_actions]}

      field(:locale, Ecto.Enum, values: [:default])

      embeds_many :call_to_actions, CallToAction, primary_key: false do
        @derive {Jason.Encoder, only: [:payload, :type, :title]}

        field(:payload, :string)
        field(:type, Ecto.Enum, values: [:web_url, :postback])
        field(:title, :string)
      end
    end
  end
end
