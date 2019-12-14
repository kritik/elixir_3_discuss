defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration
  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    alter table(:topics) do
      add :user_id, references(:users)
    end
    create index(:topics, [:user_id])
    
    create index(:users, [:email], concurrently: true)
  end
end
