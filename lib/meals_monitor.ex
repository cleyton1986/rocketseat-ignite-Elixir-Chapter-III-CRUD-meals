defmodule MealsMonitor do
  alias MealsMonitor.Meals.Create, as: CreateMeal
  alias MealsMonitor.Meals.Delete, as: DeleteMeal
  alias MealsMonitor.Meals.Get, as: GetMeal
  alias MealsMonitor.Meals.Update, as: UpdateMeal

  alias MealsMonitor.Users.Create, as: CreateUser
  alias MealsMonitor.Users.Get, as: GetUser

  defdelegate create_meal(params), to: CreateMeal, as: :call
  defdelegate get_meal_by_id(id), to: GetMeal, as: :by_id
  defdelegate get_meal_by_user_id(user_id), to: GetMeal, as: :by_user_id
  defdelegate update_meal(params), to: UpdateMeal, as: :call
  defdelegate delete_meal(id), to: DeleteMeal, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate get_users(), to: GetUser, as: :all
end
