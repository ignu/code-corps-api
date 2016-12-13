defmodule CodeCorps.TaskView do
  use CodeCorps.PreloadHelpers, default_preloads: [:project, :user, :task_list, :comments]
  use CodeCorps.Web, :view
  use JaSerializer.PhoenixView

  attributes [:body, :markdown, :number, :task_type, :status, :state, :title, :rank, :inserted_at, :updated_at]

  has_one :project, serializer: CodeCorps.ProjectView
  has_one :user, serializer: CodeCorps.UserView
  has_one :task_list, serializer: CodeCorps.TaskListView

  has_many :comments, serializer: CodeCorps.CommentView, identifiers: :always
end
