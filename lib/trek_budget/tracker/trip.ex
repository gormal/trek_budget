defmodule TrekBudget.Tracker.Trip do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "trips" do
    field :end_date, :date
    field :name, :string
    field :start_date, :date

    timestamps()
  end

  @doc false
  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [:name, :start_date, :end_date])
    |> validate_required([:name, :start_date, :end_date])
  end
end
