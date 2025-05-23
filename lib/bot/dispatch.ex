defmodule Instex.Bot.Dispatch do
  @moduledoc """
  Dispatch behaviour
  """

  alias Instex.Types

  @type t :: module()

  @callback dispatch_update(Types.update(), Types.token()) :: :ok
  @callback dispatch_update_raw(Types.update(), Types.token()) :: :ok
end
