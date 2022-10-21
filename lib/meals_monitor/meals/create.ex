defmodule MealsMonitor.Meals.Create do
  alias Ecto.Changeset
  alias MealsMonitor.{Error, Meal, Repo}

  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Meal{}} = result), do: result

  defp handle_insert({:error, %Changeset{} = changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
