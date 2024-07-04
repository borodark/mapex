defmodule Mapex.FoodPermits do
  @moduledoc """
  The FoodPermits context.
  """

  alias Mapex.FoodPermitsData

  alias Mapex.FoodPermits.Establishment

  @doc """
  Returns the list of food_vendors.

  ## Examples

      iex> list_food_vendors()
      [%Establishment{}, ...]

  """
  def list_food_vendors do
    FoodPermitsData.all()
  end

  @doc """
  Returns the list of food_vendors serving a particular dish.

  ## Examples

  iex> search_vendors_serving(dish)
  [%Establishment{}, ...]

  """
  def search_vendors_serving(dish) do
    FoodPermitsData.search(dish)
  end

  @doc """
  Gets a single establishment.

  Raises `Ecto.NoResultsError` if the Establishment does not exist.

  ## Examples

      iex> get_establishment!(123)
      %Establishment{}

      iex> get_establishment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_establishment!(object_id) do
    object_id
    |> String.to_integer()
    |> FoodPermitsData.get!()
  end
end
