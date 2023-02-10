defmodule TodoList do
  @moduledoc """
  TodoList keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias TodoList.Modules.TodoList.{Delete, GetAll, GetBy, Save, Update}
  alias TodoList.Todo

  @type uuid() :: <<_::288>>

  @spec list_todos :: [Ecto.Schema.t() | term()]
  defdelegate list_todos(), to: GetAll, as: :call

  @spec get_todo_by([{atom(), term()}]) :: [Ecto.Schema.t() | term()]
  defdelegate get_todo_by(attrs), to: GetBy, as: :call

  @spec create_todo(%Todo{}) :: Ecto.Schema.t()
  defdelegate create_todo(todo), to: Save, as: :call

  @spec update_todo(uuid(), %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          Ecto.Schema.t()
  defdelegate update_todo(id, values), to: Update, as: :call

  @spec delete_todo(uuid()) :: {non_neg_integer(), nil | [term()]}
  defdelegate delete_todo(id), to: Delete, as: :call
end
