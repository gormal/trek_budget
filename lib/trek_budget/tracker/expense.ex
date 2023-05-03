defmodule TrekBudget.Tracker.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "expenses" do
    field :amount, :float
    field :category, :string
    field :currency, :string
    field :date, :date
    field :description, :string
    belongs_to :trip, TrekBudget.Tracker.Trip

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:trip_id, :amount, :currency, :category, :description, :date])
    |> validate_required([:trip_id, :amount, :currency, :category, :description, :date])
  end
end
