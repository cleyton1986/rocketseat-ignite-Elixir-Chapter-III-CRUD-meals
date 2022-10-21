defmodule MealsMonitor.Meals.Update do
  alias Ecto.Changeset
  alias MealsMonitor.{Error, Meal, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_meal_not_found()}
      %Meal{} = meal -> do_update(meal, params)
    end
  end

  def do_update(%Meal{} = meal, params) do
    meal
    |> Meal.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Meal{}} = result), do: result

  defp handle_update({:error, %Changeset{} = changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
