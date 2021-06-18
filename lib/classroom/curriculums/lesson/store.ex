defmodule Classroom.Venues.Building.Store do
  use Agent
  alias Classroom.Venues.Building

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add(%Building{} = building) do
    Agent.update(__MODULE__, fn state -> [building | state] end)
  end

  def all do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def get(building_id) do
    Agent.get(__MODULE__, fn state ->
      Enum.find(state, fn building ->
        building.id == building_id
      end)
    end)
  end
end
