defmodule TrekBudgetWeb.AccountControllerTest do
  use TrekBudgetWeb.ConnCase

  import TrekBudget.AccountsFixtures

  alias TrekBudget.Accounts.Account

  @create_attrs %{
    email: "some@email.cz",
    hash_password: "some hash_password",
    full_name: "user 1"
  }
  @update_attrs %{
    email: "some updated email",
    hash_password: "some updated hash_password"
  }
  @invalid_attrs %{email: nil, hash_password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/api/accounts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "hash_password" => "some hash_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "hash_password" => "some updated hash_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account_signin]

    @tag :wip
    test "deletes chosen account", %{conn: conn, id: id} do
      IO.inspect(conn)
      IO.inspect(id)
      conn = delete(conn, ~p"/api/accounts/delete/#{id}")
      assert response(conn, 204)
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end

  defp create_account_signin(context) do
    account_conn = post(context.conn, ~p"/api/accounts/create", account: @create_attrs)
    %{"email" => email} = json_response(account_conn, 200)["data"]
    %{"id" => id} = json_response(account_conn, 200)["data"]
    %{"token" => token} = json_response(account_conn, 200)["data"]

    final_conn = post(context.conn |> put_req_header("authorization", "Bearer #{token}"), ~p"/api/accounts/sign_in", %{
      "email": "#{email}",
      "hash_password": "#{@create_attrs.hash_password}"
    })

    %{conn: final_conn, id: id}
  end
end
