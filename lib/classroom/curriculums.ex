defmodule Classroom.Curriculums do
  alias __MODULE__.Lesson

  defdelegate new_lesson(params),
    to: Lesson,
    as: :new

  defdelegate all_lessons,
    to: Lesson.Store,
    as: :all

  defdelegate get_lesson(lesson_id),
    to: Lesson.Store,
    as: :get

  defdelegate store_lesson(lesson),
    to: Lesson.Store,
    as: :add
end
