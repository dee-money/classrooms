defmodule Classroom.Venues.Room do
  defstruct [:id, :number, :building_id]

  defmodule Store do
    use Classroom.Storage.Base, module: Classroom.Venues.Room
  end

  alias Classroom.Venues

  def new(%Venues.Building{id: building_id}, %{number: number}) do
    %__MODULE__{
      id: UUID.uuid4(),
      number: number,
      building_id: building_id
    }
  end

  def building(%__MODULE__{building_id: building_id}), 
    do: Venues.get_building(building_id)
end