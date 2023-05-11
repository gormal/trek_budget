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

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      hash_password: account.hash_password
    }
  end

  defp data(%Account{} = account, token) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
