defmodule TodoList.Modules.TodoList.GetAll do
  alias TodoList.Todo
  alias TodoList.Repo

  import Ecto.Query

  @spec call :: [Ecto.Schema.t() | term()]
  def call do
    Repo.all(
      from t in Todo,
        where: is_nil(t.deleted_at),
        order_by: [asc: :index],
        select: t
    )
  end
end
