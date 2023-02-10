defmodule TodoList.Repo.Migrations.Todos do
  use Ecto.Migration

  @moduledoc """
  This module...

  create table todos(
    id UUID primary key
    description text not null
    is_checked boolean default false
    index integer
    insert_at Timestamp default now()
    updated_at Timestamp default now()
  )
  """
  def up do
    create table(:todos) do
      add :description, :text, null: false
      add :is_checked, :boolean, default: false
      add :index, :integer
      add :deleted_at, :timestamp

      timestamps()
    end
  end

  def down do
    drop table("todos")
  end
end
