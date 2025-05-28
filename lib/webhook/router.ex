defmodule Instex.Webhook.Router do
  @moduledoc false

  require Logger

  use Plug.Router, copy_opts_to_assign: :__opts__

  def init(opts) do
    opts
  end

  plug :match
  plug Plug.Parsers, parsers: [:json], pass: ["*/*"], json_decoder: Jason
  plug :dispatch

  get "/__instagram_webhook__" do
    Instex.Webhook.V2.verify_webhook(conn)
  end

  post "/__instagram_webhook__" do
    Instex.Webhook.V2.events(conn)
  end

  get "/oauth/fb" do
    __MODULE__.oauth(conn, opts)
  end

  # coveralls-ignore-start

  get "/test" do
    __MODULE__.test(conn, opts)
  end

  get "/" do
    Plug.Conn.send_resp(conn, :ok, "")
  end

  match _ do
    Plug.Conn.send_resp(conn, :not_found, "")
  end

  # coveralls-ignore-stop

  def oauth(conn, params) do
    Plug.Conn.send_resp(conn, :ok, "")
  end
end
