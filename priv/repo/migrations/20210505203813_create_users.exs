defmodule MealsMonitor.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table :users do
      add :name, :string, size: 100, null: false
      add :email, :string, size: 100, null: false
      add :cpf, :string, size: 11, null: false

      timestamps()
    end

    create index :users, [:email], unique: true

    create index :users, [:cpf], unique: true

    alter table :meals do
      add :user_id, references(:users), null: false
    end
  end
end
