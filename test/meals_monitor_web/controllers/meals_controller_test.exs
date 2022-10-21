defmodule MealsMonitorWeb.MealsControllerTest do
  use MealsMonitorWeb.ConnCase, async: true

  import MealsMonitor.Factory

  describe "create/2" do
    test "when all params are valid, creates a meal", %{conn: conn} do
      params = build(:meal_params)

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "data" => %{
                 "meal" => %{
                   "calorias" => "100000.00",
                   "data" => "2025-01-01T00:00:00",
                   "descricao" => "banana",
                   "id" => _id
                 }
               },
               "message" => "Meal created!",
               "success" => true
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      invalid_params = %{}

      response =
        conn
        |> post(Routes.meals_path(conn, :create, invalid_params))
        |> json_response(:bad_request)

      expected_response = %{
        "success" => false,
        "message" => %{
          "calorias" => ["can't be blank"],
          "data" => ["can't be blank"],
          "descricao" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "show/2" do
    setup do
      meal = insert(:meal)

      {:ok, meal: meal}
    end

    test "when there is an meal with the given id, returns the meal", %{conn: conn, meal: meal} do
      id = meal.id

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "meal" => %{
                   "calorias" => "100000.00",
                   "data" => "2025-01-01T00:00:00",
                   "descricao" => "banana",
                   "id" => _id
                 }
               },
               "success" => true
             } = response
    end

    test "when the id is invalid, returns an error", %{conn: conn} do
      invalid_id = "banana"

      response =
        conn
        |> get(Routes.meals_path(conn, :show, invalid_id))
        |> json_response(:bad_request)

      expected_response = %{
        "success" => false,
        "message" => "Invalid id format!"
      }

      assert response == expected_response
    end

    test "when there is no meal with the given id, returns an error", %{conn: conn} do
      invalid_id = 999_999_999

      response =
        conn
        |> get(Routes.meals_path(conn, :show, invalid_id))
        |> json_response(:not_found)

      expected_response = %{
        "success" => false,
        "message" => "Meal not found!"
      }

      assert response == expected_response
    end
  end

  describe "update/2" do
    setup do
      meal = insert(:meal)

      {:ok, meal: meal}
    end

    test "when there is an meal with the given id, updates the meal", %{conn: conn, meal: meal} do
      id = meal.id
      params = build(:meal_params, %{"id" => nil, "descricao" => "super banana"})

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, params))
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "meal" => %{
                   "calorias" => "100000.00",
                   "data" => "2025-01-01T00:00:00",
                   "descricao" => "super banana",
                   "id" => ^id
                 }
               },
               "message" => "Meal updated!",
               "success" => true
             } = response
    end

    test "when the id is invalid, returns an error", %{conn: conn} do
      id = "banana"

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, %{}))
        |> json_response(:bad_request)

      expected_response = %{
        "success" => false,
        "message" => "Invalid id format!"
      }

      assert response == expected_response
    end

    test "when there is no meal with the given id, returns an error", %{conn: conn} do
      id = 999_999_999

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id, %{}))
        |> json_response(:not_found)

      expected_response = %{
        "success" => false,
        "message" => "Meal not found!"
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    setup do
      meal = insert(:meal)

      {:ok, meal: meal}
    end

    test "when there is an meal with the given id, deletes the meal", %{conn: conn, meal: meal} do
      id = meal.id

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> response(:no_content)

      expected_response = ""

      assert response == expected_response
    end

    test "when the id is invalid, returns an error", %{conn: conn} do
      id = "banana"

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> json_response(:bad_request)

      expected_response = %{
        "success" => false,
        "message" => "Invalid id format!"
      }

      assert response == expected_response
    end

    test "when there is no meal with the given id, returns an error", %{conn: conn} do
      id = 999_999_999

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{
        "success" => false,
        "message" => "Meal not found!"
      }

      assert response == expected_response
    end
  end
end
