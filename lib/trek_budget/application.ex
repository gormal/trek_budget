defmodule TrekBudget.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TrekBudgetWeb.Telemetry,
      # Start the Ecto repository
      TrekBudget.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TrekBudget.PubSub},
      # Start Finch
      {Finch, name: TrekBudget.Finch},
      # Start the Endpoint (http/https)
      TrekBudgetWeb.Endpoint
      # Start a worker by calling: TrekBudget.Worker.start_link(arg)
      # {TrekBudget.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TrekBudget.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrekBudgetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
