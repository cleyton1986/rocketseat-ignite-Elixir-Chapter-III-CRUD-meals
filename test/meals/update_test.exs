defmodule MealsMonitor.Meals.UpdateTest do
  use MealsMonitor.DataCase, async: true

  import MealsMonitor.Factory

  alias Ecto.Changeset
  alias MealsMonitor.{Error, Meal}
  alias MealsMonitor.Meals.Update

  describe "call/1" do
    setup do
      meal = insert(:meal)

      {:ok, id: meal.id}
    end

    test "when all params are valid, updated the meal", %{id: id} do
      params = build(:meal_params, %{"id" => id, "descricao" => "super banana"})

      expected_calorias =
        params
        |> Map.get("calorias")
        |> Decimal.new()

      response = Update.call(params)

      assert {
               :ok,
               %Meal{
                 id: _id,
                 descricao: "super banana",
                 calorias: ^expected_calorias,
                 data: ~N[2025-01-01 00:00:00]
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{id: id} do
      invalid_params = %{
        "id" => id,
        "descricao" => String.duplicate("banana", 100),
        "calorias" => Decimal.new(999_999)
      }

      response = Update.call(invalid_params)

      expected_errors = %{
        calorias: ["must be less than or equal to 100000"],
        descricao: ["should be at most 100 character(s)"]
      }

      assert {
               :error,
               %Error{
                 status: :bad_request,
                 result: %Changeset{} = changeset
               }
             } = response

      assert errors_on(changeset) == expected_errors
    end

    test "when there is no meal with the given id, returns an error" do
      response = Update.call(%{"id" => 999_999_999})

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
