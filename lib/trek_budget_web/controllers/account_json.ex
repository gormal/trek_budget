defmodule TrekBudgetWeb.AccountJSON do
  alias TrekBudget.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account, token: token}) do
    %{data: data(account, token)}
  end

  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account, token) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      full_name: account.user.full_name
    }
  end
end
