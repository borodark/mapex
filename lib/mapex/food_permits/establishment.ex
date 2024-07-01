defmodule Mapex.FoodPermits.Establishment do
  use Ecto.Schema
  import Ecto.Changeset

  # APPROVED, EXPIRED,  ISSUED,  REQUESTED

  embedded_schema do
    field(:objectid, :id)
    field(:applicant, :string)
    field(:facilitytype, :string)
    field(:locationdescription, :string)
    field(:address, :string)
    field(:permit, :string)
    field(:status, :string)
    field(:fooditems, :string)
    field(:latitude, :float)
    field(:longitude, :float)
  end

  @doc false
  def changeset(establishment, attrs) do
    establishment
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
