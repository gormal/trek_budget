defmodule TrekBudget.TrackerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TrekBudget.Tracker` context.
  """

  @doc """
  Generate a trip.
  """
  def trip_fixture(attrs \\ %{}) do
    {:ok, trip} =
      attrs
      |> Enum.into(%{
        end_date: ~D[2023-05-01],
        name: "some name",
        start_date: ~D[2023-05-01]
      })
      |> TrekBudget.Tracker.create_trip()

    trip
  end

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        category: "some category",
        currency: "some currency",
        date: ~D[2023-05-01],
        description: "some description"
      })
      |> TrekBudget.Tracker.create_expense()

    expense
  end
end
