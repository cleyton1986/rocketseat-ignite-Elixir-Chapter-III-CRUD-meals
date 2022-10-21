defmodule MealsMonitor.Users.Create do
  alias Ecto.Changeset
  alias MealsMonitor.{Error, Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, %Changeset{} = changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
