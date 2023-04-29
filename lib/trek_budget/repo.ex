defmodule TrekBudget.Repo do
  use Ecto.Repo,
    otp_app: :trek_budget,
    adapter: Ecto.Adapters.Postgres
end
