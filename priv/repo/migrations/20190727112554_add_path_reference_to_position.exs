defmodule GpsServer.Repo.Migrations.AddPathReferenceToPosition do
  use Ecto.Migration

  def change do
    alter table("positions") do
      add :path_id, references(:paths)
    end

    create index("positions", [:path_id])
  end
end
