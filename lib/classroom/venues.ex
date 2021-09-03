defmodule Classroom.Venues do
  alias __MODULE__.Building

  defdelegate new_building(parent_building, params), 
    to: Building,
    as: :new

  defdelegate new_building(params),
    to: Building,
    as: :new

  defdelegate store_building(building),
    to: Building.Store,
    as: :add

  defdelegate all_buildings(),
    to: Building.Store,
    as: :all

  defdelegate get_building(building_id),
    to: Building.Store,
    as: :get

  defdelegate update_building(building, params),
    to: Building.Store,
    as: :update

  alias __MODULE__.Room

  defdelegate new_room(building, params),
    to: Room,
    as: :new

  defdelegate store_room(room),
    to: Room.Store,
    as: :add

  defdelegate all_rooms(),
    to: Room.Store,
    as: :all

  defdelegate get_room(room_id),
    to: Room.Store,
    as: :get
end
