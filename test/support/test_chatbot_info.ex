defmodule Test.ChatBotInfo do
  @moduledoc false

  use Instex.ChatBot

  @impl Instex.ChatBot
  def init(_chat) do
    {:ok, nil}
  end

  @impl Instex.ChatBot
  def handle_update(%{"message" => %{"chat" => %{"id" => chat_id}}}, token, nil) do
    Instex.Api.request(token, "testResponse", chat_id: chat_id, text: "ok")

    {:ok, nil}
  end

  @impl Instex.ChatBot
  def handle_info({:test, pid}, _token, _chat_id, nil) do
    send(pid, :ok)
    {:ok, nil}
  end
end
