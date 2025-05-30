defmodule Instex.Api do
  @moduledoc """
  Instex Bot API - HTTP-based interface
  """

  @type parameter_name :: atom() | String.t()
  @type parameter_value ::
          integer()
          | float()
          | String.t()
          | boolean()
          | {:json, json_serialized_object :: term()}
          | {:file, path :: Path.t()}
          | {:file_content, content :: iodata(), filename :: String.t()}
  @type parameters :: [{parameter_name(), parameter_value()}]
  @type request_result :: {:ok, term()} | {:error, term()}

  @doc """
  Send a Instex Bot API request.

  The request `parameters` map to the bots API parameters.

  - `Integer String Boolean Float`: Elixir native data type
  - `JSON-serialized`: `{:json, _}` tuple
  - `InputFile`: `{:file, _}` or `{:file_content, _, _}` tuple

  Reference: [BOT Api](https://core.telegram.org/bots/api)
  """
  @spec request(Instex.Types.token(), Instex.Types.method(), parameters()) :: request_result()
  def request(token, method, parameters \\ []) do
    body =
      parameters
      |> do_json_serialized_params()
      |> do_body()

    Instex.Client.request(token, method, body)
  end

  @doc """
  Download a file.

  Reference: [BOT Api](https://core.telegram.org/bots/api#file)

  Example:

  ```elixir
  # send a photo
  {:ok, res} = Instex.Api.request(token, "sendPhoto", chat_id: 12345, photo: {:file, "example/photo.jpg"})
  # pick the 'file_obj' with the desired resolution
  [file_obj | _] = res["photo"]
  # get the 'file_id'
  file_id = file_obj["file_id"]

  # obtain the 'file_path' to download the file identified by 'file_id'
  {:ok, %{"file_path" => file_path}} = Instex.Api.request(token, "getFile", file_id: file_id)
  {:ok, file} = Instex.Api.file(token, file_path)
  ```
  """
  @spec file(Instex.Types.token(), String.t()) :: request_result()
  def file(token, file_path) do
    Instex.Client.file(token, file_path)
  end

  defp do_body(parameters) do
    if request_with_file?(parameters) do
      # body encoded as "multipart/form-data"
      do_multipart_body(parameters)
    else
      # body encoded as "application/json"
      Map.new(parameters)
    end
  end

  defp request_with_file?(parameters) do
    Enum.any?(
      parameters,
      &(match?({_name, {:file, _}}, &1) or match?({_name, {:file_content, _, _}}, &1))
    )
  end

  defp do_multipart_body(parameters) do
    Enum.reduce(parameters, Tesla.Multipart.new(), fn
      {name, {:file, file}}, multipart ->
        Tesla.Multipart.add_file(multipart, file, name: to_string(name))

      {name, {:file_content, file_content, filename}}, multipart ->
        Tesla.Multipart.add_file_content(multipart, file_content, filename, name: to_string(name))

      {name, value}, multipart ->
        Tesla.Multipart.add_field(multipart, to_string(name), to_string(value))
    end)
  end

  defp do_json_serialized_params(parameters) do
    Enum.map(parameters, fn
      {name, {:json, value}} ->
        {name, Jason.encode!(value)}

      others ->
        others
    end)
  end
end
