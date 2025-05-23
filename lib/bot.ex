defmodule Instex.Bot do
  @moduledoc ~S"""
  Instex Bot behaviour.

  ## Example

  ```elixir
  defmodule HelloBot do
    use Instex.Bot

    @impl Instex.Bot
    def handle_update(
      %{"message" => %{"text" => "/hello", "chat" => %{"id" => chat_id, "username" => username}, "message_id" => message_id}},
      token
    ) do
      Instex.Api.request(token, "sendMessage",
        chat_id: chat_id,
        reply_to_message_id: message_id,
        text: "Hello #{username}!"
      )
    end

    def handle_update(_update, _token) do
      # ignore unknown updates

      :ok
    end
  end
  ```
  """

  alias Instex.Bot.Utils
  alias Instex.Types

  @doc """
  The function receives the telegram update event.
  """
  @callback handle_update(update :: Types.update(), token :: Types.token()) :: any()
  @callback handle_update_raw(update :: Types.update(), token :: Types.token()) :: any()

  @doc false
  defmacro __using__(_use_opts) do
    quote location: :keep do
      require Logger

      @behaviour Instex.Bot
      @behaviour Instex.Bot.Dispatch

      @spec child_spec(Types.bot_opts()) :: Supervisor.child_spec()
      def child_spec(bot_opts) do
        token = Keyword.fetch!(bot_opts, :token)
        max_bot_concurrency = Keyword.get(bot_opts, :max_bot_concurrency, Types.default_max_bot_concurrency())

        supervisor_name = Utils.name(__MODULE__, token)
        Supervisor.child_spec({Task.Supervisor, name: supervisor_name, max_children: max_bot_concurrency}, [])
      end

      @impl Instex.Bot.Dispatch
      def dispatch_update(update, token) do
        supervisor_name = Utils.name(__MODULE__, token)

        supervisor_name
        |> Task.Supervisor.start_child(__MODULE__, :handle_update, [update, token])
        |> case do
          {:ok, _server} ->
            :ok

          {:error, :max_children} ->
            Logger.info("Reached max children, update dropped", bot: __MODULE__, token: token)
        end
      end

      @impl Instex.Bot.Dispatch
      def dispatch_update_raw(update, token) do
        supervisor_name = Utils.name(__MODULE__, token)

        supervisor_name
        |> Task.Supervisor.start_child(__MODULE__, :handle_update_raw, [update, token])
        |> case do
          {:ok, _server} ->
            :ok

          {:error, :max_children} ->
            Logger.info("Reached max children, update dropped", bot: __MODULE__, token: token)
        end
      end
    end
  end
end
