defmodule TrekBudget.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TrekBudget.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hash_password: "some hash_password"
      })
      |> TrekBudget.Accounts.create_account()

    account
  end
end
