defmodule TrekBudget.Repo.Migrations.AddTables do
  use Ecto.Migration

  def change do
    create table(:trips) do
      add :name, :string
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end

    create table(:expenses) do
      add :amount, :float
      add :currency, :string
      add :category, :string
      add :description, :string
      add :date, :date

      add :trip_id, references(:trips, on_delete: :delete_all)

      timestamps()
    end
  end
end


# defmodule TrekBudget.Trip do
#   use Ecto.Schema

#   schema "trips" do
#     field :name, :string
#     field :start_date, :date
#     field :end_date, :date

#     has_many :expenses, TrekBudget.Expense

#     timestamps()
#   end
# end

# defmodule TrekBudget.Expense do
#   use Ecto.Schema

#   schema "expenses" do
#     field :amount, :float
#     field :currency, :string
#     field :category, :string
#     field :description, :string
#     field :date, :date

#     belongs_to :trip, TrekBudget.Trip

#     timestamps()
#   end
# end
