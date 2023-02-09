defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    oauth_google_url = ElixirAuthGoogle.generate_oauth_url(conn)
    render(conn, "index.html", oauth_google_url: oauth_google_url)
  end
end
