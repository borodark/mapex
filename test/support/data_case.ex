defmodule Mapex.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Mapex.DataCase
      import Mapex.DataCase
      alias Mapex.FoodPermits.Establishment
    end
  end

  setup tags do
    Mapex.DataCase.setup_sandbox(tags)
    :ok
  end

  def setup_sandbox(tags) do
    # pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Mapex.Repo, shared: not tags[:async])
    # on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end
end
