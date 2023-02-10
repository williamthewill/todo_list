defmodule TodoList.TodoListTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import TodoList.Factory

  alias TodoList.Todo

  @invalid_params %{}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TodoList.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(TodoList.Repo, {:shared, self()})
    :ok
  end

  describe "changeset/2" do
    test "when params is valid, returns a valid changeset" do
      changeset =
        %{
          description: "Tarefa"
        }
        |> Todo.changeset()

      assert changeset.valid?
    end

    test "when params is not valid, returns a invalid changeset" do
      changeset = @invalid_params |> Todo.changeset()

      refute changeset.valid?
    end
  end

  describe "list_todos/0" do
    test "successfully" do
      _todo_fac = insert(:todo)
      todos = TodoList.list_todos()

      assert [todo_fac] = todos
    end
  end

  describe "create_todo/1" do
    test "successfully" do
      success = TodoList.create_todo(%Todo{description: "test"})

      assert %Todo{description: "test"} = success
    end
  end

  describe "update_todo/1" do
    test "successfully" do
      todo_fac = insert(:todo)

      [before_update] = TodoList.get_todo_by(id: todo_fac.id)

      success = TodoList.update_todo(todo_fac.id, %{checked?: true})

      assert %Todo{checked?: false} = before_update
      assert %Todo{checked?: true} = success
    end
  end

  describe "delete_todo/1" do
    test "successfully" do
      todo_fac = insert(:todo)

      TodoList.delete_todo(todo_fac.id)

      success = TodoList.get_todo_by(id: todo_fac.id)

      assert [] = success
    end
  end
end
