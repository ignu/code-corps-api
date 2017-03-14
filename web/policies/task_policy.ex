defmodule CodeCorps.TaskPolicy do
  import CodeCorps.Helpers.Policy,
    only: [get_project: 1, get_membership: 2, get_role: 1, admin_or_higher?: 1]

  alias CodeCorps.{Task, User}
  alias Ecto.Changeset

  def create?(%User{admin: true}, %Changeset{}), do: true
  def create?(%User{} = user, %Changeset{changes: %{user_id: author_id}}) do
    # non admins can only create tasks for themself.
    user.id == author_id
  end
  def create?(%User{}, %Changeset{}), do: false

  def update?(%User{} = user, %Task{user_id: author_id} = task) do
    cond do
      # author can update own task
      user.id == author_id -> true
      # organization admin or higher can update other people's tasks
      task |> get_project |> get_membership(user) |> get_role |> admin_or_higher? -> true
      # do not permit for any other case
      true -> false
    end
  end
end
