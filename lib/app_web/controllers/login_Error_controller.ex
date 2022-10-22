defmodule AppWeb.LoginError do
  use Phoenix.Controller

  @moduledoc """
  Fallback for GoogleAuthCtrl and OneTapCtrl errors, returns to "/" and display flash error
  """
  def call(conn, {:error, message}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_flash(:error, inspect(message))
    |> put_view(AppWeb.PageView)
    |> redirect(to: AppWeb.Router.Helpers.page_path(conn, :index))
    |> halt()
  end
end

# nb: first call fetch_session, then fetch_flash, in THIS order
