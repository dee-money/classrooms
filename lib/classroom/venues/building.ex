defmodule Classroom.Venues.Building do
  defstruct [:id, :name]

  defmodule Store do
    use Classroom.Storage.Base, module: Classroom.Venues.Building
  end

  def new(%{name: name}) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name
    }
  end
end