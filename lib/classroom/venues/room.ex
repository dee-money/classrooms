defmodule Classroom.Venues.Room do
  @derive Jason.Encoder
  defstruct [:id, :room, :lesson, :pupil, :instructor,]

  def new(%{room: room, pupil: pupil}) do
    %__MODULE__{id: UUID.uuid4(), room: room, pupil: pupil}
  end

  def add_pupil(room, pupil) do
    %{room | room: room.pupil ++ pupil}
  end

  def add_instructor(room, instructor) do
    %{room | instructor: instructor}
  end

  def add_lesson(room, lesson) do
    %{room | lesson: lesson}
  end
end
