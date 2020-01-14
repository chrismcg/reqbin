defmodule ReqBin.Req do
  alias __MODULE__

  @enforce_keys [:timestamp, :headers, :content]
  defstruct [:timestamp, :headers, :content]

  def new(headers, content) do
    {:ok, %Req{
      timestamp: NaiveDateTime.utc_now,
      headers: headers,
      content: content
    }}
  end
end
