defmodule AppWeb.LoginError do
  use Phoenix.Controller

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
