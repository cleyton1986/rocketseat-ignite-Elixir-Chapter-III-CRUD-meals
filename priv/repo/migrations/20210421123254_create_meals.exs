defmodule MealsMonitor.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table "meals" do
      add :description, :string, size: 100, null: false
      add :date, :naive_datetime, null: false
      add :calories, :decimal, null: false, scale: 2, precision: 8
    end
  end
end
