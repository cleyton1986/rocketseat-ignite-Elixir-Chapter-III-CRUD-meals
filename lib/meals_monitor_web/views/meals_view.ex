defmodule MealsMonitorWeb.MealsView do
  use MealsMonitorWeb, :view

  alias MealsMonitor.Meal

  def render("created.json", %{meal: %Meal{} = meal}) do
    %{
      success: true,
      message: "Meal created!",
      data: %{
        meal: meal
      }
    }
  end

  def render("updated.json", %{meal: %Meal{} = meal}) do
    %{
      success: true,
      message: "Meal updated!",
      data: %{
        meal: meal
      }
    }
  end

  def render("show.json", %{meal: %Meal{} = meal}) do
    %{
      success: true,
      data: %{
        meal: meal
      }
    }
  end

  def render("all.json", %{meals: meals}) do
    %{
      success: true,
      data: %{
        meals: meals
      }
    }
  end
end
