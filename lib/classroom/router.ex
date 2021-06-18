defmodule Classroom.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/building" do
    building = Classroom.Venues.all_buildings()

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(building))
  end
end
