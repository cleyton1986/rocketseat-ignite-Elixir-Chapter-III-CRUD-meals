defmodule MealsMonitor.Meals.Get do
  import Ecto.Query

  alias MealsMonitor.{Error, Meal, Repo, User}
  alias MealsMonitor.Users.Get, as: GetUser

  def by_id(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_meal_not_found()}
      %Meal{} = meal -> {:ok, meal}
    end
  end

  def by_user_id(user_id) do
    with {:ok, %User{}} <- GetUser.by_id(user_id),
         result <- Repo.all(from m in Meal, select: m, where: m.user_id == ^user_id) do
      {:ok, result}
    end
  end
end
