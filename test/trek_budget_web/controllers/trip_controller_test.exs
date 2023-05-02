defmodule TrekBudgetWeb.TripControllerTest do
  use TrekBudgetWeb.ConnCase

  import TrekBudget.TrackerFixtures

  alias TrekBudget.Tracker.Trip

  @create_attrs %{
    end_date: ~D[2023-05-01],
    name: "some name",
    start_date: ~D[2023-05-01]
  }
  @update_attrs %{
    end_date: ~D[2023-05-02],
    name: "some updated name",
    start_date: ~D[2023-05-02]
  }
  @invalid_attrs %{end_date: nil, name: nil, start_date: 245}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trips", %{conn: conn} do
      conn = get(conn, ~p"/api/trips")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trip" do
    test "renders trip when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/trips", trip: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/trips/#{id}")

      assert %{
               "id" => ^id,
               "end_date" => "2023-05-01",
               "name" => "some name",
               "start_date" => "2023-05-01"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/trips", trip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trip" do
    setup [:create_trip]

    test "renders trip when data is valid", %{conn: conn, trip: %Trip{id: id} = trip} do
      conn = put(conn, ~p"/api/trips/#{trip}", trip: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/trips/#{id}")

      assert %{
               "id" => ^id,
               "end_date" => "2023-05-02",
               "name" => "some updated name",
               "start_date" => "2023-05-02"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, trip: trip} do
      conn = put(conn, ~p"/api/trips/#{trip}", trip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trip" do
    setup [:create_trip]

    test "deletes chosen trip", %{conn: conn, trip: trip} do
      conn = delete(conn, ~p"/api/trips/#{trip}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/trips/#{trip}")
      end
    end
  end

  defp create_trip(_) do
    trip = trip_fixture()
    %{trip: trip}
  end
end
