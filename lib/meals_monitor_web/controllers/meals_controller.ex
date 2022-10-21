defmodule MealsMonitorWeb.MealsController do
  use MealsMonitorWeb, :controller

  alias MealsMonitor.Meal
  alias MealsMonitorWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- MealsMonitor.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("created.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- MealsMonitor.get_meal_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", meal: meal)
    end
  end

  def show_by_user(conn, %{"id" => user_id}) do
    with {:ok, meals} <- MealsMonitor.get_meal_by_user_id(user_id) do
      conn
      |> put_status(:ok)
      |> render("all.json", meals: meals)
    end
  end

  def update(conn, params) do
    with {:ok, %Meal{} = meal} <- MealsMonitor.update_meal(params) do
      conn
      |> put_status(:ok)
      |> render("updated.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Meal{}} <- MealsMonitor.delete_meal(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
