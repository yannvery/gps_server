defmodule GpsServer.Coordinate do
  @behaviour Ecto.Type

  def type, do: :float

  def cast(string) when is_binary(string) do
    case Float.parse(string) do
      {float, _} -> {:ok, float}
      :error -> :error
    end
  end

  def cast(float) when is_float(float), do: {:ok, float}
  def cast(integer) when is_integer(integer), do: {:ok, Float.parse(integer)}

  def dump(float), do: {:ok, float}
  def load(float), do: {:ok, float}
end
