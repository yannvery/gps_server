defmodule GpsServer.Repo.Migrations.CreatePaths do
  use Ecto.Migration

  def change do
    create table(:paths) do
      add :title, :string
      add :description, :text

      timestamps()
    end

  end
end
