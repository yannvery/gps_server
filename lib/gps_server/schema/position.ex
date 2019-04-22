defmodule GpsServer.Position do
  use Ecto.Schema

  import Ecto.Changeset

  alias GpsServer.Coordinate

  schema "positions" do
    field :longitude, Coordinate
    field :latitude, Coordinate
    field :issued_at, :naive_datetime
    timestamps()
  end

  def changeset(position, params \\ %{}) do
    position
    |> cast(params, [:longitude, :latitude, :issued_at])
    |> validate_required([:longitude, :latitude])
  end

  def to_geojson(position = %__MODULE__{}) do
    %{
      type: "Feature",
      geometry: %{
        type: "Point",
        coordinates: [position.latitude, position.longitude]
      }
    }
  end
end
