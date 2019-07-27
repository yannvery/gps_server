defmodule GpsServerWeb.PageController do
  use GpsServerWeb, :controller

  def index(conn, _params) do
    position = GpsServer.last_position()
    path = get_path()
    render(conn, "index.html", position: position, path: path)
  end

  def get_path() do
    import Ecto.Query

    query =
      from p in GpsServer.Position,
        where: p.inserted_at > type(^~N[2019-05-02 00:00:00], :naive_datetime),
        order_by: [asc: p.id]

    GpsServer.Repo.all(query)
    |> Enum.map(fn x -> [x.latitude, x.longitude] end)
  end
end
