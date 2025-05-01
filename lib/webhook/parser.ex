defmodule Instex.Webhook.Parser do



  @spec parse_webhook_entry(String.t()) :: {:ok, Instex.Struct.WebhookEvent.t()} | {:error, reason :: map()}
  def parse_webhook_entry(input) do
    with {:ok, decoded_input} <- Jason.decode(input),
      {:ok, entry} <- Instex.Struct.WebhookEvent.parse(decoded_input) do
      entry
    end
  end
end
