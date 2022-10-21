defmodule MealsMonitor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MealsMonitor.Repo,
      # Start the Telemetry supervisor
      MealsMonitorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MealsMonitor.PubSub},
      # Start the Endpoint (http/https)
      MealsMonitorWeb.Endpoint
      # Start a worker by calling: MealsMonitor.Worker.start_link(arg)
      # {MealsMonitor.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MealsMonitor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MealsMonitorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
