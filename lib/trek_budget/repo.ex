defmodule TrekBudget.Repo do
  use Ecto.Repo,
    otp_app: :trek_budget,
    adapter: Ecto.Adapters.Postgres

  # def get_trip!(id), do: TrekBudget.Trip |> Repo.get!(id)

  # def list_trips(), do: TrekBudget.Trip |> Repo.all()

  # def create_trip(attrs \\ %{}) do
  #   %TrekBudget.Trip{}
  #   |> TrekBudget.Trip.changeset(attrs)
  #   |> Repo.insert()
  # end

  # def update_trip(%TrekBudget.Trip{} = trip, attrs) do
  #   trip
  #   |> TrekBudget.Trip.changeset(attrs)
  #   |> Repo.update()
  # end

  # def delete_trip(%TrekBudget.Trip{} = trip) do
  #   trip
  #   |> Repo.delete()
  # end

  # def list_expenses(trip_id), do: TrekBudget.Expense |> where([e], e.trip_id == ^trip_id) |> Repo.all()

  # def create_expense(attrs \\ %{}) do
  #   %TrekBudget.Expense{}
  #   |> TrekBudget.Expense.changeset(attrs)
  #   |> Repo.insert()
  # end

  # def update_expense(%TrekBudget.Expense{} = expense, attrs) do
  #   expense
  #   |> TrekBudget.Expense.changeset(attrs)
  #   |> Repo.update()
  # end

  # def delete_expense(%TrekBudget.Expense{} = expense) do
  #   expense
  #   |> Repo.delete()
  # end

  # def spendings_per_day(trip_id) do
  #   TrekBudget.Expense
  #   |> where([e], e.trip_id == ^trip_id)
  #   |> group_by([e], fragment("date_trunc('day', ?)", e.date))
  #   |> select([e], %{date: fragment("date_trunc('day', ?)", e.date), sum: sum(e.amount)})
  #   |> Repo.all()
  # end

  # def total_spendings(trip_id) do
  #   TrekBudget.Expense
  #   |> where([e], e.trip_id == ^trip_id)
  #   |> select([e], sum(e.amount))
  #   |> Repo.one()
  # end

  # def spendings_per_category(trip_id) do
  #   TrekBudget.Expense
  #   |> where([e], e.trip_id == ^trip_id)
  #   |> group_by([e], e.category)
  #   |> select([e], %{category: e.category, sum: sum(e.amount)})
  #   |> Repo.all()
  # end
end
