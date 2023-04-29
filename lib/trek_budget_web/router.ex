defmodule TrekBudgetWeb.Router do
  use TrekBudgetWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TrekBudgetWeb do
    pipe_through :api
  end
end
