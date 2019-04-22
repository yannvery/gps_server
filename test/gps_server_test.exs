defmodule GpsServer.Test do
  use ExUnit.Case
  import GpsServer.Factory

  alias GpsServer.Repo

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
  end

  describe "last_position/0" do
    test "it returns the last position when available on DB" do
      position = insert(:position)
      last_position = GpsServer.last_position()

      assert last_position == position
    end

    test "returns a 0,0 position when there is no position" do
      last_position = GpsServer.last_position()

      assert last_position == %GpsServer.Position{longitude: 0, latitude: 0}
    end
  end

  test "create_position/1" do
    params = %{"latitude" => "12", "longitude" => "27", "issued_at" => ""}

    {:ok, position} = GpsServer.create_position(params)
    assert position == GpsServer.last_position()
  end
end
