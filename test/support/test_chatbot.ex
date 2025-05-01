defmodule Test.ChatBot do
  @moduledoc false

  use Instex.ChatBot

  @impl Instex.ChatBot
  def init(_chat) do
    count_state = 0
    {:ok, count_state}
  end

  @impl Instex.ChatBot
  def handle_resume({test_pid, state}) do
    send(test_pid, :resume)
    {:ok, state}
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

  @impl Instex.ChatBot
  def handle_update(%{"message" => %{"text" => "/stop", "chat" => %{"id" => chat_id}}}, token, count_state) do
    Instex.Api.request(token, "testResponse",
      chat_id: chat_id,
      text: "Bye!"
    )

    {:stop, count_state}
  end
end
