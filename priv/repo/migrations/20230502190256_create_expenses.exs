defmodule TrekBudget.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :float
      add :currency, :string
      add :category, :string
      add :description, :string
      add :date, :date
      add :trip_id, references(:trips, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:expenses, [:trip_id])
  end
end
