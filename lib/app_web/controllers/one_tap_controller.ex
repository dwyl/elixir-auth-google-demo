defmodule AppWeb.OneTapController do
  @moduledoc """
  Callback to Google's answer
  """
  use Phoenix.Controller
  action_fallback AppWeb.LoginError

  def handle(conn, %{"credential" => jwt}) do
    with {:ok, profile} <-
           App.GoogleCerts.verified_identity(jwt) do
      conn
      |> fetch_session()
      |> put_session(:profile, profile)
      |> put_view(AppWeb.WelcomeView)
      |> redirect(to: AppWeb.Router.Helpers.welcome_path(conn, :index))
    end
  end
end
