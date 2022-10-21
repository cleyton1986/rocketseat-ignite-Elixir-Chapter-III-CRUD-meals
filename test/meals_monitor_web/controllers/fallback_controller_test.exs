defmodule MealsMonitorWeb.FallbackControllerTest do
  use MealsMonitorWeb.ConnCase, async: true

  alias MealsMonitor.Error
  alias MealsMonitorWeb.FallbackController

  describe "call/2" do
    test "when there is an error with a supported status, returns the error with the status", %{
      conn: conn
    } do
      supported_status_error = %Error{status: :bad_request, result: "Meal not found!"}

      expected_response = "{\"message\":\"Meal not found!\",\"success\":false}"

      response = FallbackController.call(conn, {:error, supported_status_error}).resp_body

      assert response == expected_response
    end

    test "when there is an error without a supported status, returns the error with internal server error",
         %{conn: conn} do
      unsupported_status_error = %Error{status: :bad_gateway, result: "Bad Gateway"}

      expected_response = "{\"message\":\"Bad Gateway\",\"success\":false}"

      response = FallbackController.call(conn, {:error, unsupported_status_error}).resp_body

      assert response == expected_response
    end
  end
end
