defmodule TodoList.Modules.TodoList.GetBy do
  alias TodoList.Todo
  alias TodoList.Repo

  import Ecto.Query

  @spec call([{atom(), term()}]) :: [Ecto.Schema.t() | term()]
  def call(attrs) do
    Repo.all(
      from t in Todo,
        where: ^attrs,
        where: is_nil(t.deleted_at),
        select: t
    )
  end
end
