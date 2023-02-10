defmodule TodoList.Modules.TodoList.Delete do
  alias TodoList.Todo
  alias TodoList.Repo

  import Ecto.Query

  @type uuid() :: <<_::288>>

  @spec call(uuid()) :: {non_neg_integer(), nil | [term()]}
  def call(id) do
    date_now = NaiveDateTime.utc_now()

    total_todos =
      Repo.one(
        from t in Todo,
          where: is_nil(t.deleted_at),
          select: count(t)
      )

    with 1 <- total_todos do
      Repo.insert!(
        %Todo{
          description: "Tarefa",
          index: 0
        },
        on_conflict: :nothing
      )
    end

    from(t in Todo, where: t.id == ^id, update: [set: [deleted_at: ^date_now]])
    |> Repo.update_all([])
  end
end
