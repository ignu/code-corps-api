defmodule CodeCorps.StripeConnectAccountPolicy do
  import CodeCorps.Helpers.Policy,
    only: [get_membership: 2, get_role: 1, owner?: 1]

  alias CodeCorps.{StripeConnectAccount, User}

  def show?(%User{admin: true}, %StripeConnectAccount{}), do: true
  def show?(%User{} = user, %StripeConnectAccount{} = stripe_connect_account), do: stripe_connect_account |> get_membership(user) |> get_role |> owner?

  def create?(%User{} = user, %Ecto.Changeset{} = changeset), do: changeset |> get_membership(user) |> get_role |> owner?
  def create?(_, _), do: false

  def update?(%User{admin: true}, %StripeConnectAccount{}), do: true
  def update?(%User{} = user, %StripeConnectAccount{} = stripe_connect_account), do: stripe_connect_account |> get_membership(user) |> get_role |> owner?
end
