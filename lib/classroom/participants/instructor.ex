defmodule Classroom.Participants.Instructor do
  @derive Jason.Encoder
  defstruct [:id, :name, :expertise]

  def new(%{name: name, expertise: expertise}) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      expertise: expertise
    }
  end
end
