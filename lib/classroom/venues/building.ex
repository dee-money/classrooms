defmodule Classroom.Venues.Building do
  @derive Jason.Encoder
  defstruct [:id, :name, :parent]

  alias Classroom.Storage.Association

  defmodule Store do
    use Classroom.Storage.Base, module: Classroom.Venues.Building
  end
  
  def new(%{"name" => name}), 
    do: new(%{name: name})

  def new(%{name: name}) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name
    }
  end

  def new(%__MODULE__{} = parent_building, %{name: name}) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      parent: Association.new(parent_building)
    }
  end
end
