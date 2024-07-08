defmodule Mapex.FoodPermits.Establishment do
  use Ecto.Schema

  import Ecto.Changeset

  schema "food_vendors" do
    field(:status, :string)
    field(:address, :string)
    field(:permit, :string)
    field(:applicant, :string)
    field(:facilitytype, :string)
    field(:locationdescription, :string)
    field(:fooditems, :string)
    field(:latitude, :float)
    field(:longitude, :float)
  end

  @doc false
  def changeset(establishments, attrs) do
    establishments
    |> cast(attrs, [
      :status,
      :fooditems
    ])
    |> validate_required([
      :status,
      :fooditems
    ])
    |> validate_length(:fooditems, min: 3)

    # |> validate_subset(:status, ["APPROVED", "REQUESTED", "ISSUED", "SUSPEND", "EXPIRED"])
  end
end
