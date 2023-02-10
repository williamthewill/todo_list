defmodule TodoListWeb.TodoLive do
  use TodoListWeb, :live_view

  def mount(_params, _session, socket) do
    todos = TodoList.list_todos()

    socket =
      socket
      |> assign(:todos, todos)

    {:ok, socket}
  end

  def handle_event("toogle_checked", %{"id" => id, "value" => "on"}, socket) do
    updated_todos = update_todo_list(socket.assigns.todos, id, true)

    socket = socket |> assign(:todos, updated_todos)

    {:noreply, socket}
  end

  def handle_event("toogle_checked", %{"id" => id}, socket) do
    updated_todos = update_todo_list(socket.assigns.todos, id, false)

    socket = socket |> assign(:todos, updated_todos)

    {:noreply, socket}
  end

  def handle_event(
        "update_description",
        %{"id" => id, "updated_description" => new_description},
        socket
      ) do
    TodoList.update_todo(id, %{description: new_description})

    {:noreply, socket}
  end

  def handle_event("new_todo", %{"index_previous_sibling" => index_previous_sibling}, socket) do
    TodoList.create_todo(%TodoList.Todo{
      description: "New Todo",
      index: index_previous_sibling + 1
    })

    todos = TodoList.list_todos()

    socket =
      socket
      |> assign(:todos, todos)

    {:noreply, socket}
  end

  def handle_event("delete_todo", %{"id" => id}, socket) do
    TodoList.delete_todo(id)

    todos = TodoList.list_todos()

    socket =
      socket
      |> assign(:todos, todos)

    {:noreply, socket}
  end

  defp update_todo_list(todos, id, checked?) do
    updated_todos =
      todos
      |> Enum.map(fn todo ->
        if todo.id == id do
          %{id: id, description: todo.description, checked?: checked?}
        else
          todo
        end
      end)

    TodoList.update_todo(id, %{checked?: checked?})

    updated_todos
  end
end
