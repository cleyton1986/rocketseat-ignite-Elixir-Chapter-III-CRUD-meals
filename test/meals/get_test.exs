defmodule MealsMonitor.Meals.GetTest do
  use MealsMonitor.DataCase, async: true

  import MealsMonitor.Factory

  alias MealsMonitor.Error
  alias MealsMonitor.Meals.Get

  describe "by_id/1" do
    setup do
      meal = insert(:meal)

      {:ok, meal: meal}
    end

    test "when there is an meal with the given id, returns the meal", %{meal: meal} do
      id = meal.id

      response = Get.by_id(id)

      expected_response = {:ok, meal}

      assert response == expected_response
    end

    test "when there is no meal with the given id, returns an error" do
      response = Get.by_id(999_999_999)

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
