defmodule Instex.Struct.V22_0.API.IceBreakerResponse do
  use Instex.Struct.V22_0.Schema

  @derive {Jason.Encoder, only: [:result]}

  embedded_schema do
    field :result, Ecto.Enum, values: [:success]
  end

end
