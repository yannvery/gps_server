defmodule GpsServer.Path do
  use Ecto.Schema
  import Ecto.Changeset

  alias GpsServer.Position

  schema "paths" do
    field :description, :string
    field :title, :string
    has_many :positions, Position

    timestamps()
  end

  @doc false
  def changeset(path, attrs) do
    path
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end

  def to_geojson(path = %__MODULE__{}) do
    %{
      type: "Feature",
      properties: %{id: "path"},
      geometry: %{
        type: "LineString",
        coordinates: coordinates(path)
      }
    }
  end

  def to_geojson(nil) do
    %{}
  end

  def coordinates(nil), do: []

  def coordinates(path = %__MODULE__{}) do
    import Ecto.Query

    query =
      from p in GpsServer.Position, where: p.path_id == ^path.id, order_by: [asc: :inserted_at]

    positions = GpsServer.Repo.all(query)
    Enum.map(positions, fn p -> [p.longitude, p.latitude] end)
  end
end
