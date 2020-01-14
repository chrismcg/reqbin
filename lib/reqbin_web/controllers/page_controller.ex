defmodule ReqBinWeb.PageController do
  use ReqBinWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
