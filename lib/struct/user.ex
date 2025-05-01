defmodule Instex.Struct.User do


  defstruct [
    id: 0,
  ]

  @type t :: %__MODULE__{
    id: integer(),
  }

  @spec parse(map()) :: {:ok, __MODULE__.t()} | {:error, :invalid}
  def parse(%{"id" => id}) do
    {:ok, %__MODULE__{
      id: String.to_integer(id)
    }}
  end

end
