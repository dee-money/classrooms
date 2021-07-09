defmodule Classroom.Venues.Room do
  defstruct [:id, :number, :building]
  
  alias Classroom.Storage.Association

  defmodule Store do
    use Classroom.Storage.Base, module: Classroom.Venues.Room
  end

  alias Classroom.Venues

  def new(%Venues.Building{} = building, %{number: number}) do
    %__MODULE__{
      id: UUID.uuid4(),
      number: number,
      building: Association.new(building)
    }
  end
end