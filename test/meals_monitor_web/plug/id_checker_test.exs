defmodule MealsMonitorWeb.IdCheckerTest do
  use MealsMonitorWeb.ConnCase, async: true

  alias MealsMonitorWeb.Plug.IdChecker

  describe "call/2" do
    setup do
      IdChecker.init(%{})
    end

    test "when there is an invalid id, returns an error", %{
      conn: conn
    } do
      params = %{"id" => "banana"}

      conn = %{conn | params: params}

      expected_response = "{\"message\":\"Invalid id format!\",\"success\":false}"

      response = IdChecker.call(conn, %{}).resp_body

      assert response == expected_response
    end

    test "when there is no invalid id, returns the conn", %{
      conn: conn
    } do
      response = IdChecker.call(conn, %{})

      assert response == conn
      assert response.resp_body == nil
    end
  end
end
