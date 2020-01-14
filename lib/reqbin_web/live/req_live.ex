defmodule ReqBinWeb.ReqLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <%= for req <- assigns.reqs do %>
      <% id = DateTime.to_unix(req.timestamp, :microsecond) %>
      <div class="card fluid bordered rounded">
        <h2 class="section dark"><%= req.timestamp %></h2>
        <div class="section">
          <pre class="line-numbers" phx-hook="Highlight"><code class="language-json match-braces rainbow-braces"><%= Jason.encode!(req.content, pretty: true) %></code></pre>
          <div class="collapse">
            <input type="checkbox" id="collapse-section<%= id %>" aria-hidden="true">
            <label for="collapse-section<%= id %>">Click for headers</label>
            <div>
              <table class="striped">
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Value</th>
                  </tr>
                </thead>
                <%= for {name, content} <- req.headers do %>
                  <tr>
                    <td data-label="Name"><%= name %></th>
                    <td data-label="Value"><%= content %></td>
                  </tr>
                <% end %>
              </table>
            </div>
          </div>
        </div>
      </div>
      <hr/>
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