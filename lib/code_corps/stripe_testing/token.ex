defmodule CodeCorps.StripeTesting.Token do
  def create_on_connect_account(_customer_id, _customer_card_id, [connect_account: _] = _opts) do
    {:ok, do_create()}
  end

  defp do_create() do
    %Stripe.Token{
      id: "sub_123"
    }
  end
end
