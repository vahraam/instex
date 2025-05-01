defmodule Instex.Struct.Entry do

  defstruct [
    changes: [],
    id: 0,
    time: nil
  ]

  @type t :: %__MODULE__{
    changes: [Instex.Struct.Change.t()],
    id: integer(),
    time: NaiveDateTime.t()
  }

  @spec parse(map() | [map()]) :: {:ok, __MODULE__.t()} | {:error, :invalid}
  def parse(%{"changes" => changes, "id" => id, "time" => time} = input) when is_map(input) do
    {:ok, %__MODULE__{
      changes: Instex.Struct.Change.parse(changes),
      id: String.to_integer(id),
      # TODO
      time: time
    }}
  end

  def parse(list) when is_list(list) do
    list
    |> Enum.reduce_while([], fn item, acc ->
      parse(item)
      |> case do
        {:ok, parsed_item} -> {:cont, acc ++ [parsed_item]}
        err -> {:halt, err}
      end
    end)

  end
end
