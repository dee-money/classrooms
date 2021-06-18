defmodule Classroom.Venues do
  alias __MODULE__.Building

  defdelegate new_building(params),
    to: Building,
    as: :new

  defdelegate all_buildings,
    to: Building.Store,
    as: :all

  defdelegate get_building(building_id),
    to: Building.Store,
    as: :get

  defdelegate store_building(building),
    to: Building.Store,
    as: :add

end
