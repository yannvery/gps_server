defmodule GpsServer.Position do
  use Ecto.Schema
  import Ecto.Changeset

  alias GpsServer.Coordinate
  alias GpsServer.Path

  schema "positions" do
    field :longitude, Coordinate
    field :latitude, Coordinate
    field :issued_at, :naive_datetime
    belongs_to :path, Path

    timestamps()
  end

  def changeset(position, params \\ %{}) do
    params_with_issued_at = add_issued_at_to_params(params)

    position
    |> cast(params_with_issued_at, [:longitude, :latitude, :issued_at])
    |> associate_to_path()
    |> validate_required([:longitude, :latitude])
  end

  def to_geojson(position = %__MODULE__{}) do
    %{
      type: "Feature",
      properties: %{id: "position"},
      geometry: %{
        type: "Point",
        coordinates: [position.longitude, position.latitude]
      }
    }
  end

  # Check the last path, the last position has to be inserted at less than 5 minutes ago
  # Or create a new path
  # Link the path to the changeset
  defp associate_to_path(changeset) do
    position = GpsServer.last_position()
    path = get_or_create_path(position)
    Ecto.Changeset.put_assoc(changeset, :path, path)
  end

  defp get_or_create_path(nil) do
    {:ok, path} = GpsServer.create_path()
    path
  end

  defp get_or_create_path(position) do
    case position.path do
      %Path{} ->
        active_path(position)

      _ ->
        {:ok, path} = GpsServer.create_path()
        path
    end
  end

  defp active_path(position) do
    date_time_limit = NaiveDateTime.add(position.inserted_at, 60, :second)

    case NaiveDateTime.compare(NaiveDateTime.utc_now(), date_time_limit) do
      :lt ->
        position.path

      _ ->
        {:ok, path} = GpsServer.create_path()
        path
    end
  end

  def add_issued_at_to_params(%{"time" => epoch_string} = params) do
    epoch_time = String.to_integer(epoch_string)
    Map.put(params, "issued_at", NaiveDateTime.add(~N[1970-01-01 00:00:00], epoch_time))
  end

  def add_issued_at_to_params(%{"issued_at" => nil} = params) do
    %{params | "issued_at" => NaiveDateTime.utc_now()}
  end

  def add_issued_at_to_params(%{"issued_at" => %NaiveDateTime{}} = params) do
    params
  end

  def add_issued_at_to_params(params) do
    Map.put(params, "issued_at", NaiveDateTime.utc_now())
  end
end
