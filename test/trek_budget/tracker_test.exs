defmodule TrekBudget.TrackerTest do
  use TrekBudget.DataCase

  alias TrekBudget.Tracker

  describe "trips" do
    alias TrekBudget.Tracker.Trip

    import TrekBudget.TrackerFixtures

    @invalid_attrs %{end_date: nil, name: nil, start_date: nil}

    test "list_trips/0 returns all trips" do
      trip = trip_fixture()
      assert Tracker.list_trips() == [trip]
    end

    test "get_trip!/1 returns the trip with given id" do
      trip = trip_fixture()
      assert Tracker.get_trip!(trip.id) == trip
    end

    test "create_trip/1 with valid data creates a trip" do
      valid_attrs = %{end_date: ~D[2023-05-01], name: "some name", start_date: ~D[2023-05-01]}

      assert {:ok, %Trip{} = trip} = Tracker.create_trip(valid_attrs)
      assert trip.end_date == ~D[2023-05-01]
      assert trip.name == "some name"
      assert trip.start_date == ~D[2023-05-01]
    end

    test "create_trip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_trip(@invalid_attrs)
    end

    test "update_trip/2 with valid data updates the trip" do
      trip = trip_fixture()
      update_attrs = %{end_date: ~D[2023-05-02], name: "some updated name", start_date: ~D[2023-05-02]}

      assert {:ok, %Trip{} = trip} = Tracker.update_trip(trip, update_attrs)
      assert trip.end_date == ~D[2023-05-02]
      assert trip.name == "some updated name"
      assert trip.start_date == ~D[2023-05-02]
    end

    test "update_trip/2 with invalid data returns error changeset" do
      trip = trip_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_trip(trip, @invalid_attrs)
      assert trip == Tracker.get_trip!(trip.id)
    end

    test "delete_trip/1 deletes the trip" do
      trip = trip_fixture()
      assert {:ok, %Trip{}} = Tracker.delete_trip(trip)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_trip!(trip.id) end
    end

    test "change_trip/1 returns a trip changeset" do
      trip = trip_fixture()
      assert %Ecto.Changeset{} = Tracker.change_trip(trip)
    end
  end

  describe "expenses" do
    alias TrekBudget.Tracker.Expense

    import TrekBudget.TrackerFixtures

    @invalid_attrs %{amount: nil, category: nil, currency: nil, date: nil, description: nil}

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Tracker.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Tracker.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      valid_attrs = %{amount: 120.5, category: "some category", currency: "some currency", date: ~D[2023-05-01], description: "some description"}

      assert {:ok, %Expense{} = expense} = Tracker.create_expense(valid_attrs)
      assert expense.amount == 120.5
      assert expense.category == "some category"
      assert expense.currency == "some currency"
      assert expense.date == ~D[2023-05-01]
      assert expense.description == "some description"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      update_attrs = %{amount: 456.7, category: "some updated category", currency: "some updated currency", date: ~D[2023-05-02], description: "some updated description"}

      assert {:ok, %Expense{} = expense} = Tracker.update_expense(expense, update_attrs)
      assert expense.amount == 456.7
      assert expense.category == "some updated category"
      assert expense.currency == "some updated currency"
      assert expense.date == ~D[2023-05-02]
      assert expense.description == "some updated description"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_expense(expense, @invalid_attrs)
      assert expense == Tracker.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Tracker.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Tracker.change_expense(expense)
    end
  end
end
