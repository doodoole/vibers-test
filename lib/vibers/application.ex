defmodule Vibers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Vibers.Repo,
      # Start the Telemetry supervisor
      VibersWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Vibers.PubSub},
      # Start the Endpoint (http/https)
      VibersWeb.Endpoint
      # Start a worker by calling: Vibers.Worker.start_link(arg)
      # {Vibers.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Vibers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VibersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
