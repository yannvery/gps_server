defmodule GpsServer.Repo.Migrations.CreatePositionsTable do
  use Ecto.Migration

  def change do
    create table("positions") do
      add :longitude, :float
      add :latitude, :float
      add :issued_at, :naive_datetime
      timestamps()
    end
  end
end
