defmodule AppWeb.WelcomeController do
  use Phoenix.Controller

  def index(conn, _p) do
    profile = get_session(conn, :profile)
    render(conn, "index.html", profile: profile)
  end
end
