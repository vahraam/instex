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

  @access_token "IGAAlQgycmPN9BZAE9ZAUjF0REdQRGxCUWlkV2dMZAlR5WWtjTHJEUWUxVUJGalF5a1BpYXkwUllNemUzNVRnajc4ZAXl5WW4tSGlwNVNybV9fNDhJMjdDUEYzRS1XR1ZAmOHlLLTZAvVXY4alNicWpJVk9ERkM5cTVuRkJyX3BXRWFUawZDZD"


  # def send_message(user_platform_id, text) do

  #   url = @base_uri <> "/" <> @api_version <>  "/me/messages"

  #   Finch.build(:post, url, [
  #     {"Authorization", "Bearer " <> @access_token},
  #     {"content-type", "application/json"}
  #     ], %{
  #     recipient: %{id: user_platform_id},
  #     message: %{text: text},
  #   } |> Jason.encode!())
  #   |> Finch.request(Backend.Finch)
  # end




  @spec create_ice_breakers(access_token :: String.t(), schema :: IceBreakerRequest.t()) :: {:ok, any()} | {:error, reason :: atom()}
  def create_ice_breakers(access_token, schema) do
    url = @base_uri <> "/" <> @api_version <>  "/me/messenger_profile"
    do_request(Backend.Finch, url, access_token, schema, IceBreakerResponse)
  end

  @spec create_persistent_menu(access_token :: String.t(), schema :: PersistentMenuRequest.t()) :: {:ok, any()} | {:error, reason :: atom()}
  def create_persistent_menu(access_token, schema) do
    url = @base_uri <> "/" <> @api_version <>  "/me/messenger_profile"
    do_request(Backend.Finch, url, access_token, schema, PersistentMenuResponse)
  end

  @spec send_direct_message(access_token :: String.t(), schema :: SendDirectMessageRequest.t()) :: {:ok, SendDirectMessageResponse.t()} | {:error, reason :: atom()}
  def send_direct_message(access_token, schema) do
    url = @base_uri <> "/" <> @api_version <>  "/me/messages"
    do_request(Backend.Finch, url, access_token, schema, SendDirectMessageResponse)
  end


  @spec handle_response(Finch.Response.t(), module :: module()) :: {:ok, struct()} | any()
  defp handle_response(resp, module) do
    resp
    |> case do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        {:ok, struct(module, Jason.decode!(body, keys: :atoms))}
      other -> other
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
