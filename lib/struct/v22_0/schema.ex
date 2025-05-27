defmodule Instex.Struct.V22_0.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key false
    end
  end



end


defimpl Jason.Encoder, for: Any do
    def encode(value, opts) do
      value
      |> Map.from_struct() # or take exactly the keys you want
      |> Map.reject(fn {_k, v} -> is_nil(v) or (v == []) end) # since 1.13
      |> Jason.Encode.map(opts)
    end
  end
