defmodule GpsServerWeb.PageControllerTest do
  use GpsServerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "GpsServer · Phoenix Framework"
  end
end
