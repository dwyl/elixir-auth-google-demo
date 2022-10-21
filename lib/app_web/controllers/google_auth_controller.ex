defmodule AppWeb.GoogleAuthController do
  use AppWeb, :controller
  action_fallback AppWeb.LoginError

  @doc """
  `index/2` handles the callback from Google Auth API redirect.
  """
  def index(conn, %{"code" => code}) do
    with {:ok, token} <- ElixirAuthGoogle.get_token(code, conn),
         {:ok, profile} <- ElixirAuthGoogle.get_user_profile(token.access_token) do
      conn
      |> put_view(AppWeb.PageView)
      |> render(:welcome, profile: profile)
    end
  end
end
