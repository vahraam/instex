# coveralls-ignore-start

defmodule Instex.WebServer.Bandit do
  @moduledoc """
  Bandit child specification for `Plug` compatible webserver.

  See `Instex.Webhook`.
  """

  @spec child_spec(:inet.port_number()) :: {module(), term()}
  def child_spec(port) do
    unless Code.ensure_loaded?(Bandit) do
      raise """
      Missing :bandit dependency.

      See Instex.Webhook documentation.
      """
    end

    {Bandit,
     [
       scheme: :http,
       plug: Instex.Webhook.Router,
       port: port
     ]}
  end
end

# coveralls-ignore-stop
