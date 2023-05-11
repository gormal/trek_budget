defmodule TrekBudgetWeb.TripController do
  use TrekBudgetWeb, :controller

  alias TrekBudget.Tracker
  alias TrekBudget.Tracker.Trip

  action_fallback TrekBudgetWeb.FallbackController

  def index(conn, _params) do
    trips = Tracker.list_trips()
    render(conn, :index, trips: trips)
  end

  def create(conn, %{"trip" => trip_params}) do
    with {:ok, %Trip{} = trip} <- Tracker.create_trip(trip_params) do
      conn
      |> put_status(:created)
      |> render(:show, trip: trip)
    end
  end

  def show(conn, %{"id" => id}) do
    trip = Tracker.get_trip!(id)
    render(conn, :show, trip: trip)
  end

  def update(conn, %{"id" => id, "trip" => trip_params}) do
    trip = Tracker.get_trip!(id)

    with {:ok, %Trip{} = trip} <- Tracker.update_trip(trip, trip_params) do
      render(conn, :show, trip: trip)
    end
  end

  def delete(conn, %{"id" => id}) do
    trip = Tracker.get_trip!(id)

    with {:ok, %Trip{}} <- Tracker.delete_trip(trip) do
      send_resp(conn, :no_content, "")
    end
  end
end
