defmodule Instex.Struct.WebhookEvent do

  @type object :: nil | :instagram

  defstruct [
    entry: [],
    object: nil
  ]

  @type t :: %__MODULE__{
    entry: [Instex.Struct.Entry.t()],
    object: object()
  }


  @spec parse(map()) :: {:ok, __MODULE__.t()} | {:error, :invalid}
  def parse(%{"entry" => entry, "object" => object}) do
    with {:ok, parsed_entry} <- Instex.Struct.Entry.parse(entry) do
      {:ok, %__MODULE__{
        entry: parsed_entry,
        object: String.to_atom(object)
      }}
    end
  end
end
