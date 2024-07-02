defmodule Mapex.FoodPermitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mapex.FoodPermits` context.
  """

  @doc """
  Generate a establishments.
  """
  def establishments_fixture(attrs \\ %{}) do
    {:ok, establishments} =
      attrs
      |> Enum.into(%{
        address: "some address",
        applicant: "some applicant",
        facilitytype: "some facilitytype",
        fooditems: "some fooditems",
        latitude: 120.5,
        locationdescription: "some locationdescription",
        longitude: 120.5,
        objectid: 42,
        permit: "some permit",
        status: "some status"
      })
      |> Mapex.FoodPermits.create_establishments()

    establishments
  end
end
