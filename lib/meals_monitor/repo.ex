defmodule MealsMonitor.Repo do
  use Ecto.Repo,
    otp_app: :meals_monitor,
    adapter: Ecto.Adapters.Postgres
end
