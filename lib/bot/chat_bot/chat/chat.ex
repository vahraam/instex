defmodule Instex.ChatBot.Chat do
  @moduledoc """
  A struct that represents a chat extracted from a Instex update.
  Currently the only required field is `id`, any other data you may want to pass to
  `c:Instex.ChatBot.init/1` should be included under the `metadata` field.
  """

  @type t() :: %__MODULE__{
          id: String.t(),
          metadata: map() | nil
        }

  @enforce_keys [:id]
  defstruct [:metadata] ++ @enforce_keys
end
