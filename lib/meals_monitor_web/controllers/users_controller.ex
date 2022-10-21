defmodule MealsMonitorWeb.UsersController do
  use MealsMonitorWeb, :controller

  alias MealsMonitor.User
  alias MealsMonitorWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- MealsMonitor.create_user(params) do
      conn
      |> put_status(:created)
      |> render("created.json", %{user: user})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- MealsMonitor.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{user: user})
    end
  end
end
