defmodule Mapex.FoodPermits.Establishment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_vendors" do
    field(:objectid, :id)
    field(:status, :string)
    field(:address, :string)
    field(:permit, :string)
    field(:applicant, :string)
    field(:facilitytype, :string)
    field(:locationdescription, :string)
    field(:fooditems, :string)
    field(:latitude, :float)
    field(:longitude, :float)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(establishments, attrs) do
    establishments
    |> cast(attrs, [
      :objectid,
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
      :objectid,
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
