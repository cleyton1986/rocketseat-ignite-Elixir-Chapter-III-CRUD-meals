defmodule MealsMonitor.Meals.CreateTest do
  use MealsMonitor.DataCase, async: true

  import MealsMonitor.Factory

  alias Ecto.Changeset
  alias MealsMonitor.{Error, Meal}
  alias MealsMonitor.Meals.Create

  describe "call/1" do
    test "when all params are valid, creates a meal" do
      params = build(:meal_params)

      expected_calorias =
        params
        |> Map.get("calorias")
        |> Decimal.new()

      response = Create.call(params)

      assert {
               :ok,
               %Meal{
                 id: _id,
                 descricao: "banana",
                 calorias: ^expected_calorias,
                 data: ~N[2025-01-01 00:00:00]
               }
             } = response
    end

    test "when there are invalid params, returns an error" do
      invalid_params = %{}

      response = Create.call(invalid_params)

      expected_errors = %{
        calorias: ["can't be blank"],
        data: ["can't be blank"],
        descricao: ["can't be blank"]
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
  end
end
