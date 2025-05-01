defmodule Test.Bot do
  @moduledoc false

  use Instex.Bot

  @impl Instex.Bot
  def handle_update(_update, token) do
    Instex.Api.request(token, "testResponse")
  end
end
