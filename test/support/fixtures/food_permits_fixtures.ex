defmodule Mapex.FoodPermitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mapex.FoodPermits` context.
  """

  @doc """
  Generate a establishment.
  """
  def establishment_fixture(attrs \\ %{}) do
    {:ok, establishment} =
      attrs
      |> Enum.into(%{
        objectid: 1,
        applicant: "A",
        facilitytype: "Push Cart",
        locationdescription: "MARKET ST: DRUMM ST intersection",
        address: "5 THE EMBARCADERO",
        permit: "16MFF-0139",
        status: "REQUESTED",
        fooditems: "South American/Peruvian food",
        latitude: 37.7758255197583,
        longitude: -122.417249626643
      })
      |> Mapex.FoodPermits.create_establishment()

    establishment
  end
end
