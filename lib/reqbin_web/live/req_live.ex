defmodule ReqBinWeb.ReqLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <%= for req <- assigns.reqs do %>
      <div>
        <h2><%= req.timestamp %></h2>
        <table>
          <%= for {name, content} <- req.headers do %>
            <tr>
              <th><%= name %></th>
              <td><%= content %></td>
            </tr>
          <% end %>
        </table>
        <pre>
          <code><%= Jason.encode!(req.content, pretty: true) %></code>
         </pre>
      </div>
      <hr />
    <% end %>
    """
  end

  def mount(_params, socket) do
    if connected?(socket) do
      IO.puts("Setting up subscription")
      Phoenix.PubSub.subscribe(ReqBin.PubSub, "req:new")
    end

    reqs =
      :ets.tab2list(:req_store)
      |> Enum.map(fn {_, req} -> req end)
      |> Enum.reverse()

    {:ok, assign(socket, reqs: reqs)}
  end

  def handle_info(req, socket) do
    {:noreply, update(socket, :reqs, fn reqs -> [req | reqs] end)}
  end
end