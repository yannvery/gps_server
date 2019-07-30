defmodule GpsServerWeb.PageController do
  use GpsServerWeb, :controller

  def index(conn, _params) do
    position = GpsServer.last_position()
    path = get_path()
    render(conn, "index.html", position: position, path: path)
  end

  def get_path() do
    case GpsServer.last_path() do
      nil ->
        []

      path ->
        path = GpsServer.Repo.preload(path, :positions)
        path.positions |> Enum.map(fn x -> [x.latitude, x.longitude] end)
    end
  end
end
