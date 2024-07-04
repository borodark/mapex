defmodule Mapex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MapexWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:sfofoods, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Mapex.PubSub},
      {Mapex.FoodPermitsData, "sfo-street-foods.csv"},
      # Start the Finch HTTP client for sending emails
      # {Finch, name: Mapex.Finch},
      # Start a worker by calling: Mapex.Worker.start_link(arg)
      # {Mapex.Worker, arg},
      # Start to serve requests, typically the last entry
      MapexWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mapex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MapexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
