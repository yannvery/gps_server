defmodule GpsServer.Repo do
  use Ecto.Repo,
    otp_app: :gps_server,
    adapter: Ecto.Adapters.Postgres

  import Ecto.Query

  def last_position do
    case __MODULE__.one(from p in GpsServer.Position, order_by: [desc: p.issued_at], limit: 1) do
      nil ->
        %GpsServer.Position{longitude: 0, latitude: 0, issued_at: nil}

      position ->
        position |> __MODULE__.preload(:path)
    end
  end

  def last_path do
    __MODULE__.one(from p in GpsServer.Path, order_by: [desc: p.inserted_at], limit: 1)
  end
end
