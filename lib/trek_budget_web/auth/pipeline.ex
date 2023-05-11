defmodule TrekBudgetWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :trek_budget,
  module: TrekBudgetWeb.Auth.Guardian,
  error_handler: TrekBudgetWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
