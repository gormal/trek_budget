defmodule TrekBudgetWeb.TripJSON do
  alias TrekBudget.Tracker.Trip

  @doc """
  Renders a list of trips.
  """
  def index(%{trips: trips}) do
    %{data: for(trip <- trips, do: data(trip))}
  end

  @doc """
  Renders a single trip.
  """
  def show(%{trip: trip}) do
    %{data: data(trip)}
  end

  defp data(%Trip{} = trip) do
    %{
      id: trip.id,
      name: trip.name,
      start_date: trip.start_date,
      end_date: trip.end_date
    }
  end
end
