defmodule TrekBudgetWeb.Auth.ErrorResponse.Unauthorized do
    defexception [message: "Unauthorized", plug_status: 401]
end

defmodule TrekBudgetWeb.Auth.ErrorResponse.Forbidden do
    defexception [message: "Forbidden", plug_status: 403]
end

defmodule TrekBudgetWeb.Auth.ErrorResponse.InvalidInput do
    defexception [message: "Invalid input", plug_status: 403]
end
