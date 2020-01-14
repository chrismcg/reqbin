defmodule ReqBin.Repo do
  use Ecto.Repo,
    otp_app: :reqbin,
    adapter: Ecto.Adapters.Postgres
end
