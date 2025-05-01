defmodule Instex.Struct.Message do

  defstruct [
    mid: "",
    text: "",
  ]

  @type t :: %__MODULE__{
    mid: String.t(),
    text: String.t(),
  }


  @spec parse(map()) :: {:ok, __MODULE__.t()} | {:error, :invalid}
  def parse(%{"mid" => mid, "text" => text} = map) do
    {:ok, %__MODULE__{
      mid: mid,
      text: text
    }}
  end

end
