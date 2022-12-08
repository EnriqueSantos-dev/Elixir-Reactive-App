defmodule TodoAppWeb.TodoLive do
  use TodoAppWeb, :live_view

  def mount(_, _, socket) do
    todos = []
    filtered_todos = todos
    active_filter = "all"

    socket = 
      socket
      |> assign(:todos, todos)
      |> assign(:filtered_todos, filtered_todos)
      |> assign(:active_filter, active_filter)
      |> actives_todos()

    {:ok, socket}
  end

  def handle_event("new_todo_form", %{"new_todo" => %{"message" => message}}, socket) do
    todo = %{id: Ecto.UUID.generate(), description: message, completed: false}

    socket =
      socket
      |> assign(:todos, [todo] ++ socket.assigns.todos)
      |> actives_todos()
      |> filter_todos()

    {:noreply, socket}
  end

  def handle_event("select_all_todos", _params, socket) do
    socket = 
      socket
      |> assign(:todos, 
          Enum.map(socket.assigns.todos, fn todo -> %{todo | completed: true} end)
          )
      |> actives_todos()
      |> filter_todos()

    {:noreply, socket}
  end

  def handle_event("remove_todo", %{"id" => id}, socket) do
    socket =
      socket
      |> assign(:todos, Enum.filter(socket.assigns.todos, fn todo -> todo.id != id end))
      |> filter_todos()
    
      {:noreply, socket}
  end

  def handle_event("change_filter", %{"filter" => filter}, socket) do
    socket =
      socket
      |> assign(:active_filter, filter)
      |> actives_todos()
      |> filter_todos()

    {:noreply, socket}
  end

  def handle_event("toggle_todo_status", %{"id" => id}, socket) do
    socket =
      socket 
      |> assign(:todos, Enum.map(socket.assigns.todos, fn todo -> 
        if todo.id == id do
          %{todo | completed: not todo.completed}
        else
          todo
        end
      end))
      |> actives_todos()
      |> filter_todos()

    {:noreply, socket}
  end

  defp filter_todos(socket) do
    socket
    |> assign(:filtered_todos,
      Enum.filter(socket.assigns.todos, fn todo ->
        case socket.assigns.active_filter do
          "all" ->
            true

          "active" ->
            not todo.completed

          "completed" ->
            todo.completed
        end
      end)
    )
  end

  def actives_todos(socket) do
    socket
      |> assign(:active_todos, Enum.count(socket.assigns.todos, fn t -> not t.completed end))
  end
end