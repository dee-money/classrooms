defmodule Classroom.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Classroom.Curriculums.Lesson.Store,
      Classroom.Venues.Building.Store,
      Classroom.Venues.Room.Store,
      {Plug.Cowboy, scheme: :http, plug: Classroom.Router, options: [port: 4040]}
      # Starts a worker by calling: Classroom.Worker.start_link(arg)
      # {Classroom.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Classroom.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
