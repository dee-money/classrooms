defmodule Classroom.Router do
  use Plug.Router

  plug(:match)
  plug Plug.Parsers, 
    parsers: [:json],
    pass:  ["application/json"],
    json_decoder: Jason
  plug(:dispatch)

  get "/lessons" do
    lessons = Classroom.Curriculums.all_lessons()

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(lessons))
  end
  
  get "/buildings" do
    buildings = Classroom.Venues.all_buildings()
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(buildings))  
  end
  
  post "/buildings" do
    %{"building" => building_params} = conn.params
    building = Classroom.Venues.new_building(building_params)
    
    case Classroom.Venues.store_building(building) do
      :ok ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(201, Jason.encode!(building))
        
      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(422, Jason.encode!(%{data: %{error: "something isn't right"}}))
    end 
  end
end
