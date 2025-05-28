defmodule Instex.Webhook.V2 do
  alias Instex.Types
  import Instex.Utils, only: [retry: 1]
  require Logger

  # use GenServer

  @default_scheme "https"
  @default_port 443
  @default_local_port 4000
  @default_max_connections 40

  @default_config [
    scheme: @default_scheme,
    port: @default_port
  ]

  @spec post_webhook(Plug.Conn.t(), Types.token()) :: Plug.Conn.t()
  def post_webhook(%Plug.Conn{} = conn, token) do
    bot_routing_map = :persistent_term.get({Instex.Webhook, :bot_routing_map})

    with {:read_update, {:ok, update, conn}} <- {:read_update, read_update(conn)},
         {:routing, {:ok, bot_dispatch_behaviour}} <- {:routing, Map.fetch(bot_routing_map, token)} do
      Logger.debug("received update: #{inspect(update)}", bot: inspect(bot_dispatch_behaviour))
      bot_dispatch_behaviour.dispatch_update(update, token)
      Plug.Conn.send_resp(conn, :ok, "")
    else
      # coveralls-ignore-start

      {:read_update, _} ->
        Plug.Conn.send_resp(conn, :bad_request, "")

      {:routing, :error} ->
        Plug.Conn.send_resp(conn, :not_found, "")

        # coveralls-ignore-stop
    end
  end

  def events(%Plug.Conn{assigns: %{__opts__: %{callback_module: callback_module}}} = conn) do
    with {:read_update, {:ok, update, conn}} <- {:read_update, read_update(conn)} do
      :ok = callback_module.dispatch_update_raw(update)

      Plug.Conn.send_resp(conn, :ok, "")
    else
      # coveralls-ignore-start

      {:read_update, _} ->
        Plug.Conn.send_resp(conn, :bad_request, "")

      {:routing, :error} ->
        Plug.Conn.send_resp(conn, :not_found, "")

        # coveralls-ignore-stop
    end
  end

  def verify_webhook(%Plug.Conn{params: %{"hub.challenge" => challenge_code} = _params} = conn) do
    Plug.Conn.send_resp(conn, :ok, challenge_code)
  end

  def verify_webhook(%Plug.Conn{} = conn) do
    Plug.Conn.send_resp(conn, :ok, "")
  end

  # coveralls-ignore-start

  defp read_update(%Plug.Conn{body_params: %Plug.Conn.Unfetched{}} = conn) do
    with {:read, {:ok, body, conn}} <- {:read, Plug.Conn.read_body(conn)},
         {:parse, {:ok, update}} <- {:parse, Instex.Webhook.Parser.parse_webhook_entry(body)} do
      {:ok, update, conn}
    else
      {:read, error} ->
        {:error, error}

      {:parse, error} ->
        error
    end
  end

  # coveralls-ignore-stop

  defp read_update(%Plug.Conn{body_params: %{}} = conn) do
    {:ok, conn.body_params, conn}
  end
end
