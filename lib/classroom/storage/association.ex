defmodule Classroom.Storage.Association do
  defstruct [:resource_id, :call]
  
  def new(%m{id: resource_id}) do
  	%__MODULE__{
		  resource_id: resource_id,
      call: m
		}
  end
end