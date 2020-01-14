defmodule ReqBinWeb.ReqController do
  use ReqBinWeb, :controller

  def create(conn, params) do
    {:ok, req} = ReqBin.Req.new(conn.req_headers, params)
    :ets.insert(:req_store, {:erlang.unique_integer([:monotonic, :positive]), req})

    text(conn, "Nom!!")
  end
end
