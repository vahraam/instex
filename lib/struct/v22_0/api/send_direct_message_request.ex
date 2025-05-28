defmodule Instex.Struct.V22_0.API.SendDirectMessageRequest do
  use Instex.Struct.V22_0.Schema

  @derive {Jason.Encoder, only: [:message, :recipient, :messaging_type]}

  embedded_schema do
    embeds_one :message, Message, primary_key: false do
      @derive {Jason.Encoder, only: [:text, :attachment, :quick_replies]}
      field(:text, :string)

      embeds_one :attachment, Attachment, primary_key: false do
        @derive {Jason.Encoder, only: [:type, :payload]}
        field(:type, Ecto.Enum, values: [:template, :image])

        embeds_one :payload, Payload, primary_key: false do
          @derive {Jason.Encoder, only: [:template_type, :elements]}
          field(:template_type, Ecto.Enum, values: [:generic])

          embeds_many :elements, Element do
            @derive {Jason.Encoder, only: [:title, :image_url, :subtitle]}
            field(:title, :string)
            field(:image_url, :string)
            field(:subtitle, :string)

            embeds_one :default_action, DefaultAction, primary_key: false do
              @derive {Jason.Encoder, only: [:type, :url]}
              field(:type, Ecto.Enum, values: [:web_url])
              field(:url, :string)
            end

            embeds_many :buttons, Button, primary_key: false do
              @derive {Jason.Encoder, only: [:type, :url, :title, :payload]}
              field(:type, Ecto.Enum, values: [:web_url, :postback])
              field(:url, :string)
              field(:title, :string)
              field(:payload, :string)
            end
          end
        end
      end

      embeds_many :quick_replies, QuickReply, primary_key: false do
        @derive {Jason.Encoder, only: [:content_type, :title, :payload]}
        field(:content_type, Ecto.Enum, values: [:text])
        field(:title, :string)
        field(:payload, :string)
      end
    end

    embeds_one :recipient, Recipient, primary_key: false do
      @derive {Jason.Encoder, only: [:id]}
      field(:id, :string)
      field(:comment_id, :string)
    end

    field(:messaging_type, Ecto.Enum, values: [:RESPONSE])
  end
end
