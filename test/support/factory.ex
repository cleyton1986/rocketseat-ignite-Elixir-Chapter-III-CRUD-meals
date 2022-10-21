defmodule MealsMonitor.Factory do
  use ExMachina.Ecto, repo: MealsMonitor.Repo

  alias MealsMonitor.Meal

  def meal_params_factory do
    %{
      "descricao" => "banana",
      "data" => "2025-01-01 00:00:00",
      "calorias" => "100000.00"
    }
  end

  def meal_factory do
    %Meal{
      id: 1,
      descricao: "banana",
      data: ~N[2025-01-01 00:00:00],
      calorias: Decimal.new("100000.00")
    }
  end
end
