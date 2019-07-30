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
end
