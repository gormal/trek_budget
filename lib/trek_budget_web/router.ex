defmodule TrekBudgetWeb.Router do
  use TrekBudgetWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TrekBudgetWeb do
    pipe_through :api
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
    resources "/trips", TripController
  end
end
