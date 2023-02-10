defmodule TodoList.Factory do
  use ExMachina.Ecto, repo: TodoList.Repo

  def todo_factory do
    %TodoList.Todo{
      id: "b66f4e27-4611-4045-8672-e6c11abcf607",
      description: "Tarefa",
      index: 0,
      inserted_at: ~N[2023-02-10 22:09:04],
      updated_at: ~N[2023-02-10 22:09:04]
    }
  end
end
