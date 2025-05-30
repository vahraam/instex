#!/usr/bin/env elixir

Mix.install(
  [
    {:telegram, github: "visciang/telegram", branch: "master"},
    {:finch, "~> 0.19"}
  ],
  # force: true,
  config_path: "example/config/runtime.exs"
)

defmodule SleepBot do
  use Instex.Bot

  @impl Instex.Bot
  def handle_update(
        %{"message" => %{"text" => "/sleep" <> seconds_arg, "chat" => %{"id" => chat_id}, "message_id" => message_id}},
        token
      ) do
    seconds = seconds_arg |> parse_seconds_arg()
    Command.sleep(token, chat_id, message_id, seconds)
  end

  def handle_update(update, token) do
    Command.unknown(token, update)
  end

  defp parse_seconds_arg(arg) do
    default_arg = "1"
    arg = if arg == "", do: default_arg, else: arg
    {seconds, ""} = arg |> String.trim() |> Integer.parse()
    seconds
  end
end

defmodule Command do
  require Logger

  def sleep(token, chat_id, message_id, seconds) do
    Instex.Api.request(token, "sendMessage",
      chat_id: chat_id,
      reply_to_message_id: message_id,
      text: "Sleeping '#{seconds}'s"
    )

    Process.sleep(seconds * 1_000)

    Instex.Api.request(token, "sendMessage",
      chat_id: chat_id,
      reply_to_message_id: message_id,
      text: "Awake!"
    )
  end

  def unknown(token, update) do
    unknown_message = "Unknown message:\n\n```\n#{inspect(update, pretty: true)}\n```"

    case update do
      %{"message" => %{"message_id" => message_id, "chat" => %{"id" => chat_id}}} ->
        Instex.Api.request(token, "sendMessage",
          chat_id: chat_id,
          reply_to_message_id: message_id,
          parse_mode: "MarkdownV2",
          text: unknown_message
        )

      _ ->
        Logger.debug(unknown_message)
    end
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
      {Instex.Poller, bots: [{SleepBot, token: token, max_bot_concurrency: 1_000}]}
    ],
    strategy: :one_for_one
  )

Process.sleep(:infinity)
