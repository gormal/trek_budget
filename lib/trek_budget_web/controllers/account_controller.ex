defmodule TrekBudgetWeb.AccountController do
  use TrekBudgetWeb, :controller

  alias TrekBudgetWeb.{Auth.ErrorResponse, Auth.Guardian}
  alias TrekBudget.{Accounts, Accounts.Account, Users, Users.User}

  plug :is_valid_input when action in [:delete, :update]
  plug :is_authorized_account when action in [:update, :delete]

  defp is_valid_input(conn, _opts) do
    case conn do
      %{params: %{"id" => _id}} ->
        conn

      %{params: %{"account" => _params}} ->
        conn

      _ ->
        raise ErrorResponse.InvalidInput
    end
  end

  defp is_authorized_account(conn, _opts) do
    id = case conn do
      %{params: %{"id" => id}} ->
        id

      %{params: %{"account" => params}} ->
        params["id"]
    end
    account = Accounts.get_account!(id)

    if conn.assigns.account.id == account.id do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  action_fallback TrekBudgetWeb.FallbackController

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["hash_password"])
    end
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    authorize_account(conn, email, hash_password)
  end

  defp authorize_account(conn, email, hash_password) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:show, %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def refresh_session(conn, %{}) do
    old_token = Guardian.Plug.current_token(conn)

    claims =
      Guardian.decode_and_verify(old_token)
      |> refresh_session_validation()

    account =
      Guardian.resource_from_claims(claims)
      |> refresh_session_validation()

    new_token =
      Guardian.refresh(old_token)
      |> refresh_session_validation()

    conn
    |> Plug.Conn.put_session(:account_id, account.id)
    |> put_status(:ok)
    |> render(:show, %{account: account, token: new_token})
  end

  defp refresh_session_validation({:ok, value}), do: value
  defp refresh_session_validation({:ok, _old, {value, _claims}}), do: value
  defp refresh_session_validation({:error, _reason}), do: raise(ErrorResponse.NotFound)

  def sign_out(conn, %{}) do
    account = conn.assigns[:account]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render(:show, %{account: account, token: nil})
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_full_account(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"account" => account_params}) do
    account = Accounts.get_account!(account_params["id"])

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
