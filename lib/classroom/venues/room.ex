defmodule Classroom.Venues.Room do
  @derive Jason.Encoder
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

  def search([{key, value}]) do
    Store.all()
    |> Enum.filter(fn room -> 
      room = Map.from_struct(room)

      case Map.get(room, key) do
        %Classroom.Storage.Association{resource_id: id} ->
          id == value.id

        data -> data == value
      end
    end)
  end
end
