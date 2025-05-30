defmodule Instex.V22_0.Api do
  alias Instex.Struct.V22_0.API.{
    IceBreakerRequest,
    IceBreakerResponse,
    PersistentMenuRequest,
    PersistentMenuResponse,
    SendDirectMessageRequest,
    SendDirectMessageResponse
  }

  @base_uri "https://graph.instagram.com"
  @api_version "v22.0"

  @spec create_ice_breakers(access_token :: String.t(), schema :: IceBreakerRequest.t()) ::
          {:ok, any()} | {:error, reason :: atom()}
  def create_ice_breakers(access_token, schema, finch) do
    url = @base_uri <> "/" <> @api_version <> "/me/messenger_profile"
    do_request(finch, url, access_token, schema, IceBreakerResponse)
  end

  @spec create_persistent_menu(access_token :: String.t(), schema :: PersistentMenuRequest.t()) ::
          {:ok, any()} | {:error, reason :: atom()}
  def create_persistent_menu(access_token, schema, finch) do
    url = @base_uri <> "/" <> @api_version <> "/me/messenger_profile"
    do_request(finch, url, access_token, schema, PersistentMenuResponse)
  end

  @spec send_direct_message(access_token :: String.t(), schema :: SendDirectMessageRequest.t()) ::
          {:ok, SendDirectMessageResponse.t()} | {:error, reason :: atom()}
  def send_direct_message(access_token, schema, finch) do
    url = @base_uri <> "/" <> @api_version <> "/me/messages"
    do_request(finch, url, access_token, schema, SendDirectMessageResponse)
  end

  @spec handle_response(Finch.Response.t(), module :: module()) :: {:ok, struct()} | any()
  defp handle_response(resp, module) do
    resp
    |> case do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        {:ok, struct(module, Jason.decode!(body, keys: :atoms))}

      other ->
        other
    end
  end

  defp do_request(finch, url, access_token, body, resp_mod) do
    Finch.build(
      :post,
      url,
      [
        {"Authorization", "Bearer " <> access_token},
        {"content-type", "application/json"}
      ],
      body |> Jason.encode!()
    )
    |> Finch.request(finch)
    |> handle_response(resp_mod)
  end
end
