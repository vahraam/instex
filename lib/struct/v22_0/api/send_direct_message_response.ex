defmodule Instex.Struct.V22_0.API.SendDirectMessageResponse do
  use Instex.Struct.V22_0.Schema

  @derive {Jason.Encoder, only: [:recipient_id, :message_id]}

  embedded_schema do
    field(:recipient_id, :string)
    field(:message_id, :string)
  end
end
