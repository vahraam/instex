# coveralls-ignore-start

defmodule Instex.WebServer.Cowboy do
  @moduledoc """
  Cowboy child specification for `Plug` compatible webserver.

  See `Instex.Webhook`.
  """

  @spec child_spec(:inet.port_number()) :: {module(), term()}
  def child_spec(port) do
    unless Code.ensure_loaded?(Plug.Cowboy) do
      raise """
      Missing :plug_cowboy dependency.

      See Instex.Webhook documentation.
      """
    end

    {Plug.Cowboy,
     [
       scheme: :http,
       plug: Instex.Webhook.Router,
       options: [
         port: port
       ]
     ]}
  end
end

# coveralls-ignore-stop
