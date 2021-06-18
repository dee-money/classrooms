defmodule Classroom.Venues.Building do
  @derive Jason.Encoder
  defstruct [:id, :building, :room]

  def new(%{building: building, room: room}) do
    %__MODULE__{id: UUID.uuid4(), building: building, room: room}
  end

  def add_room(building, room) do
    %{building | room: building.room ++ room}
  end
end
