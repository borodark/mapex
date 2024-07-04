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
      :applicant,
      :facilitytype,
      :locationdescription,
      :address,
      :permit,
      :status,
      :fooditems,
      :latitude,
      :longitude
    ])
    |> validate_required([
      :applicant,
      :facilitytype,
      :locationdescription,
      :address,
      :permit,
      :status,
      :fooditems,
      :latitude,
      :longitude
    ])
  end
end
