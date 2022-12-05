defmodule TodoAppWeb.Button do
  use Phoenix.Component

  def button(assigns) do
    ~H"""
      <button 
        class="rounded border p-2 font-semibold" 
        phx-click="change_filter" 
        phx-value-filter={@filter}
        style={if @active_filter == @filter, do: "background-color: rgb(37, 99, 235); color: white;", else: "background-color: transparent; color: rgb(63, 66,70);"}
        >
        <%= @text %>
      </button>
    """
  end
end