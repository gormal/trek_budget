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
    field :trip_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:amount, :currency, :category, :description, :date])
    |> validate_required([:amount, :currency, :category, :description, :date])
  end
end
