defmodule Mapex.FoodPermitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mapex.FoodPermits` context.
  """

  @doc """
  Generate a establishments.
  """
  def establishments_fixture(_attrs \\ %{}) do
    "755221" |> Mapex.FoodPermits.get_establishment!()
  end
end
