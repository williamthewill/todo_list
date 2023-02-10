defmodule TodoList.Todo do
  @moduledoc false

  use TodoList.Schema
  import Ecto.Changeset

  @doc since: "1.0.0"
  schema "todos" do
    field(:description, :string)
    field(:checked?, :boolean, source: :is_checked)
    field(:index, :integer)
    field(:deleted_at, :naive_datetime_usec)

    timestamps()
  end

  @doc since: "1.0.0"
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:description, :checked?, :deleted_at])
    |> validate_required([:description])
  end
end
