defmodule TrekBudget.Repo.Migrations.CreateTrips do
  use Ecto.Migration

  def change do
    create table(:trips, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end
  end
end
