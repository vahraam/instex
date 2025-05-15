defmodule Instex.Struct.Old.Optin do
  use Instex.Struct.Old.Schema


  embedded_schema do
    field :type, :string
    field :notification_messages_token, :string
    field :notification_messages_frequency, :string
    field :token_expiry_timestamp, :integer
    field :user_token_status, :string
    field :notification_messages_timezone, :string
    field :title, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:type,
    :notification_messages_token,
    :notification_messages_frequency,
    :token_expiry_timestamp,
    :user_token_status,
    :notification_messages_timezone,
    :title]
    )
  end
end
