defmodule Instex.Client do
  @moduledoc false

  @type file_path :: String.t()
  @type body :: map() | Tesla.Multipart.t()

  @api_base_url Application.compile_env(:instex, :api_base_url, "https://graph.instagram.com")
  @api_max_retries Application.compile_env(:instex, :api_max_retries, 5)

  use Tesla, only: [:get, :post], docs: false

  plug Tesla.Middleware.BaseUrl, @api_base_url
  plug Tesla.Middleware.JSON

  require Logger

  plug Tesla.Middleware.Retry,
    max_retries: @api_max_retries,
    should_retry: fn
      {:ok, %{status: 429}} ->
        Logger.warning("Instex API throttling, HTTP 429 'Too Many Requests'")
        true

      {:ok, _} ->
        false

      {:error, _} ->
        true
    end

  @doc false
  @spec request(String.t(), Instex.Types.token(), Instex.Types.method(), body()) :: {:ok, term()} | {:error, term()}
  def request(path, token, method, body) do
    path
    |> post(body)
    |> process_response()
  end

  defp process_response({:ok, env}) do
    case env.body do
      %{"ok" => true, "result" => result} ->
        {:ok, result}

      %{"ok" => false, "description" => description} ->
        {:error, description}

      _ ->
        {:error, {:http_error, env.status}}
    end
  end

  defp process_response({:error, reason}) do
    {:error, reason}
  end
end
