defmodule GpsServerWeb.Api.PositionControllerTest do
  use GpsServerWeb.ConnCase

  describe "GET /api/position" do
    test "returns default coordinates", %{conn: conn} do
      conn = get(conn, "/api/position")

      assert json_response(conn, 200) == %{
               "geometry" => %{"coordinates" => [0, 0], "type" => "Point"},
               "type" => "Feature",
               "properties" => %{}
             }
    end
  end

  describe "POST /api/position" do
    test "returns created geo_json point", %{conn: conn} do
      params = %{latitude: "12", longitude: "24"}
      conn = post(conn, "/api/position", params)

      assert json_response(conn, 201) == %{
               "geometry" => %{"coordinates" => [24.0, 12.0], "type" => "Point"},
               "type" => "Feature",
               "properties" => %{}
             }
    end

    test "returns an error with an invalid latitude", %{conn: conn} do
      params = %{longitude: "24"}
      conn = post(conn, "/api/position", params)

      assert json_response(conn, 400) == %{"latitude" => ["can't be blank"]}
    end
  end
end
