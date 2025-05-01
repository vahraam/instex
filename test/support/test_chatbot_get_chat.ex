defmodule Test.ChatBotGetChat do
  @moduledoc false

  use Instex.ChatBot

  @impl Instex.ChatBot
  def get_chat("inline_query", %{"id" => inline_chat_id}) do
    {:ok, %Instex.ChatBot.Chat{id: inline_chat_id}}
  end

  def get_chat(_, %{"chat" => %{"id" => chat_id}}) do
    {:ok, %Instex.ChatBot.Chat{id: chat_id}}
  end

  def get_chat(_, _) do
    :ignore
  end

  @impl Instex.ChatBot
  def init(_chat) do
    count_state = 0
    {:ok, count_state}
  end

  @impl Instex.ChatBot
  def handle_update(%{"inline_query" => %{"id" => query_id, "query" => query}}, token, count_state) do
    count_state = count_state + 1

    Instex.Api.request(token, "testResponse",
      query_id: query_id,
      query: query,
      text: "#{count_state}"
    )

    {:stop, count_state}
  end

  @impl Instex.ChatBot
  def handle_update(%{"message" => %{"text" => "/count", "chat" => %{"id" => chat_id}}}, token, count_state) do
    count_state = count_state + 1

    Instex.Api.request(token, "testResponse",
      chat_id: chat_id,
      text: "#{count_state}"
    )

    {:ok, count_state}
  end
end
