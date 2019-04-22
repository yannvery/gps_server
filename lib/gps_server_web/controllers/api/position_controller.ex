defmodule GpsServerWeb.Api.PositionController do
  use GpsServerWeb, :controller

  def show(conn, _params) do
    geo_point = GpsServer.last_position() |> GpsServer.Position.to_geojson()
    json(conn, geo_point)
  end

  def create(conn, params) do
    case GpsServer.create_position(params) do
      {:ok, position} ->
        {:ok, geo_point} =
          position
          |> GpsServer.Position.to_geojson()
          |> Jason.encode()

        conn
        |> put_resp_content_type("application/json")
        |> Plug.Conn.resp(201, geo_point)
        |> send_resp()

      {:error, changeset} ->
        {:ok, body} =
          Ecto.Changeset.traverse_errors(changeset, fn
            {msg, opts} -> String.replace(msg, "%{count}", to_string(opts[:count]))
            msg -> msg
          end)
          |> Jason.encode()

        conn
        |> put_resp_content_type("application/json")
        |> Plug.Conn.resp(400, body)
        |> send_resp()
    end
  end
end
