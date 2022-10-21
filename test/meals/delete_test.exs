defmodule MealsMonitor.Meals.DeleteTest do
  use MealsMonitor.DataCase, async: true

  import MealsMonitor.Factory

  alias MealsMonitor.{Error, Meal}
  alias MealsMonitor.Meals.Delete

  describe "call/1" do
    setup do
      meal = insert(:meal)

      {:ok, id: meal.id}
    end

    test "when there is an meal with the given id, deletes the meal", %{id: id} do
      response = Delete.call(id)

      assert {:ok, %Meal{}} = response
    end

    test "when there is no meal with the given id, returns an error" do
      response = Delete.call(999_999_999)

      assert {
               :error,
               %Error{
                 status: :not_found,
                 result: "Meal not found!"
               }
             } = response
    end
  end
end
