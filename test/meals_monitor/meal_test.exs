defmodule MealsMonitor.MealTest do
  use MealsMonitor.DataCase, async: true

  import MealsMonitor.Factory

  alias Decimal
  alias Ecto.Changeset
  alias MealsMonitor.Meal

  describe "changeset/2" do
    test "when it is a new meal and all params are valid, returns a valid changeset" do
      params = build(:meal_params)

      response = Meal.changeset(params)

      expected_calorias = Decimal.new("100000.00")

      assert %Changeset{
               changes: %{
                 descricao: "banana",
                 data: ~N[2025-01-01 00:00:00],
                 calorias: calorias
               },
               valid?: true
             } = response

      assert calorias == expected_calorias
    end

    test "when it is meal and all params are valid, returns a valid changeset" do
      params = %{"descricao" => "super banana"}
      meal = build(:meal)

      response = Meal.changeset(meal, params)

      assert %Changeset{
               changes: %{
                 descricao: "super banana"
               },
               valid?: true
             } = response
    end

    test "when there are missing params, returns a changeset with errors" do
      params = %{}

      response = Meal.changeset(params)

      expected_response = %{
        calorias: ["can't be blank"],
        data: ["can't be blank"],
        descricao: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end

    test "when 'descricao' is too long, returns a changeset with errors" do
      params = build(:meal_params, %{"descricao" => String.duplicate("banana", 100)})

      response = Meal.changeset(params)

      expected_response = %{descricao: ["should be at most 100 character(s)"]}

      assert errors_on(response) == expected_response
    end

    test "when 'calorias' is too big, returns a changeset with errors" do
      params = build(:meal_params, %{"calorias" => "100001"})

      response = Meal.changeset(params)

      expected_response = %{calorias: ["must be less than or equal to 100000"]}

      assert errors_on(response) == expected_response
    end
  end
end
