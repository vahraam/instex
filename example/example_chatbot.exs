#!/usr/bin/env elixir

Mix.install(
  [
    {:telegram, github: "visciang/telegram", branch: "master"},
    {:finch, "~> 0.19"}
  ],
  # force: true,
  config_path: "example/config/runtime.exs"
)

defmodule CountChatBot do
  require Logger

  use Instex.ChatBot

  @session_ttl 60 * 1_000

  @impl Instex.ChatBot
  def init(_chat) do
    count_state = 0
    {:ok, count_state, @session_ttl}
  end

  @impl Instex.ChatBot
  def handle_update(%{"message" => %{"chat" => %{"id" => chat_id}}}, token, count_state) do
    count_state = count_state + 1

    Instex.Api.request(token, "sendMessage",
      chat_id: chat_id,
      text: "Hey! You sent me #{count_state} messages"
    )

    {:ok, count_state, @session_ttl}
  end

  def handle_update(update, _token, count_state) do
    Logger.info("Unknown update received: #{inspect(update)}")

    {:ok, count_state, @session_ttl}
  end
end

token = System.get_env("BOT_TOKEN")

if token == nil do
  IO.puts(:stderr, "Please provide a BOT_TOKEN environment variable")
  System.halt(1)
end

{:ok, _} =
  Supervisor.start_link(
    [
      {Finch, name: Adapter.Finch},
      {Instex.Poller, bots: [{CountChatBot, token: token, max_bot_concurrency: 1_000}]}
    ],
    strategy: :one_for_one
  )

Process.sleep(:infinity)
