defmodule MealsMonitorWeb.MealsViewTest do
  use MealsMonitorWeb.ConnCase, async: true

  import Phoenix.View
  import MealsMonitor.Factory

  alias MealsMonitor.Meal
  alias MealsMonitorWeb.MealsView

  test "created.json" do
    meal = build(:meal)

    expected_calorias = meal.calorias

    response = render(MealsView, "created.json", meal: meal)

    assert %{
             data: %{
               meal: %Meal{
                 calorias: ^expected_calorias,
                 data: ~N[2025-01-01 00:00:00],
                 descricao: "banana",
                 id: 1
               }
             },
             message: "Meal created!",
             success: true
           } = response
  end

  test "updated.json" do
    meal = build(:meal)

    expected_calorias = meal.calorias

    response = render(MealsView, "updated.json", meal: meal)

    assert %{
             data: %{
               meal: %Meal{
                 calorias: ^expected_calorias,
                 data: ~N[2025-01-01 00:00:00],
                 descricao: "banana",
                 id: 1
               }
             },
             message: "Meal updated!",
             success: true
           } = response
  end

  test "show.json" do
    meal = build(:meal)

    expected_calorias = meal.calorias

    response = render(MealsView, "show.json", meal: meal)

    assert %{
             data: %{
               meal: %Meal{
                 calorias: ^expected_calorias,
                 data: ~N[2025-01-01 00:00:00],
                 descricao: "banana",
                 id: 1
               }
             },
             success: true
           } = response
  end
end
