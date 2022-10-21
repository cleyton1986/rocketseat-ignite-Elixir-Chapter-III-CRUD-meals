defmodule MealsMonitorWeb.UsersView do
  use MealsMonitorWeb, :view

  alias MealsMonitor.User

  def render("created.json", %{user: %User{} = user}) do
    %{
      success: true,
      message: "User created!",
      data: %{
        user: user
      }
    }
  end

  def render("show.json", %{user: %User{} = user}) do
    %{
      success: true,
      data: %{
        user: user
      }
    }
  end
end
