defmodule Classroom.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/lessons" do
    lessons = Classroom.Curriculums.all_lessons()

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(lessons))
  end
end
