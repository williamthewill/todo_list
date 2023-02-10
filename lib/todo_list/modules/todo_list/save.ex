defmodule TodoList.Modules.TodoList.Save do
  alias TodoList.Repo
  alias TodoList.Todo

  import Ecto.Query

  @spec call(%Todo{}) :: Ecto.Schema.t()
  def call(%Todo{description: _} = todo) do
    from(t in Todo, where: t.index > ^todo.index - 1, update: [set: [index: t.index + 1]])
    |> Repo.update_all([])

    Repo.insert!(todo)
  end
end
