defmodule Instex.Struct.Change.Value do

  defstruct [
    message: %Instex.Struct.Message{},
    recipient: %Instex.Struct.User{},
    sender: %Instex.Struct.User{},
    timestamp: nil
  ]



  @type t :: %__MODULE__{
    message: Instex.Struct.Message.t(),
    recipient: Instex.Struct.User.t(),
    sender: Instex.Struct.User.t(),
    timestamp: NaiveDateTime.t(),
  }

  @spec parse(map()) :: {:ok, __MODULE__.t()} | {:error, :invalid}
  def parse(%{"message" => message, "recipient" => recipient, "sender" => sender, "timestamp" => timestamp} = _map) do
    with {:ok, parsed_message} <- Instex.Struct.Message.parse(message),
    {:ok, parsed_sender} <- Instex.Struct.User.parse(sender),
    {:ok, parsed_recipient} <- Instex.Struct.User.parse(recipient) do
      {:ok, %__MODULE__{
        message: parsed_message,
        recipient: parsed_recipient,
        sender: parsed_sender,
        # TODO
        timestamp: timestamp
      }}

    end
  end
end
