defmodule CodeCorps.GuardianSerializer do
  alias CodeCorps.{Project, Repo, User}

  @behaviour Guardian.Serializer

  def for_token(%Project{} = project), do: {:ok, "Project:#{project.id}"}
  def for_token(%User{} = user), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("Project:" <> id), do: {:ok, Repo.get(Project, id)}
  def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
