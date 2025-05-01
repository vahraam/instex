defmodule Instex.Struct.Change do

  @type field :: nil | :messages


  defstruct [
    field: nil,
    value: %Instex.Struct.Change.Value{},
  ]

  @type t :: %__MODULE__{
    field: field(),
    value: Instex.Struct.Change.Value.t()
  }

  @spec parse(map() | [map()]) :: {:ok, __MODULE__.t()} | {:error, :invalid}
  def parse(input) when is_list(input) do
    input
    |> Enum.reduce_while([], fn item, acc ->
      parse(item)
      |> case do
        {:ok, parsed_item} -> {:cont, acc ++ [parsed_item]}
        err -> {:halt, err}
      end
    end)
  end

  def parse(%{"value" => value, "field" => field} = map) when is_map(map) do
    with {:ok, parsed_value}  <- Instex.Struct.Change.Value.parse(value) do
      {:ok, %__MODULE__{
        value: parsed_value,
        field: String.to_atom(field)
      }}
    end
  end
end
