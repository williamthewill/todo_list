defmodule TodoList.Modules.TodoList.Update do
  alias TodoList.Todo
  alias TodoList.Repo

  @type uuid() :: <<_::288>>

  @spec call(uuid(), %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          Ecto.Schema.t()
  def call(id, %{} = values) do
    todo_schema = Repo.get(Todo, id)

    todo_changeset = todo_schema |> Todo.changeset(values)

    Repo.update!(todo_changeset)
  end
end
