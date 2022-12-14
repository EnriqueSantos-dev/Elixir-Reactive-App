defmodule TodoAppWeb.Todo do
  use Phoenix.Component

  def todo(assigns) do
    ~H"""
      <div class="flex space-x-3 min-h-12 border border-zinc-300 rounded items-center p-2">
        <button
          class="w-5 h-5 rounded-full border border-zinc-300"
          phx-click="toggle_todo_status"
          phx-value-id={@todo.id}
          style={if @todo.completed, do: "background-color: rgb(34,197,94);", else: "background-color: transparent"}
          />
        <p
          class="flex-1"
          style={if @todo.completed, do: "text-decoration: line-through; opacity: 0.7;"}
        >
          <%= @todo.description %>
        </p>
        <button phx-click="remove_todo" phx-value-id={@todo.id}>❌</button>
      </div>
    """
  end
end
