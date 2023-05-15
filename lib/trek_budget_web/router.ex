defmodule TrekBudgetWeb.Router do
  use TrekBudgetWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, anything) do
    IO.inspect(anything)
    conn |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug TrekBudgetWeb.Auth.Pipeline
    plug TrekBudgetWeb.Auth.SetAccount
  end

  scope "/api", TrekBudgetWeb do
    pipe_through :api
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
  end

  scope "/api", TrekBudgetWeb do
    pipe_through [:api, :auth]
    resources "/trips", TripController
    get "/accounts/:id", AccountController, :show
    post "/accounts/update", AccountController, :update
    put "/accounts/sign_out", AccountController, :sign_out
  end
end
