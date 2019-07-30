defmodule GpsServer.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: GpsServer.Repo

  def position_factory do
    %GpsServer.Position{
      longitude: 25.060531666667,
      latitude: 121.600165,
      issued_at: NaiveDateTime.utc_now(),
      path: build(:path)
    }
  end

  def path_factory do
    %GpsServer.Path{
      title: "title",
      description: "description"
    }
  end
end
