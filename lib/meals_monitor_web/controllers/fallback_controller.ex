defmodule MealsMonitorWeb.FallbackController do
  use MealsMonitorWeb, :controller

  alias MealsMonitor.Error
  alias MealsMonitorWeb.ErrorView

  @accepted_status [:bad_request, :not_found, :unauthorized]

  def call(conn, {:error, %Error{status: status, result: result}})
      when status in @accepted_status do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end

  def call(conn, {:error, %Error{status: _status, result: result}}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
