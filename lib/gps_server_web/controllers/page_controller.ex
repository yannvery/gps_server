defmodule GpsServerWeb.PageController do
  use GpsServerWeb, :controller

  def index(conn, _params) do
    position = GpsServer.last_position()
    render(conn, "index.html", position: position)
  end
end
