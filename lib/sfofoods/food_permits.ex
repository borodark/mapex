defmodule Mapex.FoodPermits do
  @moduledoc """
  The FoodPermits context.
  """

  import Ecto.Query, warn: false
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
  Gets a single establishment.

  Raises `Ecto.NoResultsError` if the Establishment does not exist.

  ## Examples

      iex> get_establishment!(123)
      %Establishment{}

      iex> get_establishment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_establishment!(object_id) do
    FoodPermitsData.get!(object_id)
  end

  @doc """
  Creates an establishment.

  ## Examples

      iex> create_establishment(%{field: value})
      {:ok, %Establishment{}}

      iex> create_establishment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_establishment(attrs \\ %{}) do
    %Establishment{}
    |> Establishment.changeset(attrs)
    |> FoodPermitsData.store()
  end

  @doc """
  Updates an establishment.

  ## Examples

      iex> update_establishment(establishment, %{field: new_value})
      {:ok, %Establishment{}}

      iex> update_establishment(establishment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_establishment(%Establishment{} = establishment, attrs) do
    establishment
    |> Establishment.changeset(attrs)
    |> FoodPermitsData.store()
  end

  @doc """
  Deletes an establishment.

  ## Examples

      iex> delete_establishment(establishment)
      {:ok, %Establishment{}}

      iex> delete_establishment(establishment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_establishment(%Establishment{} = establishment) do
    establishment
    |> FoodPermitsData.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking establishments changes.

  ## Examples

      iex> change_establishment(establishment)
      %Ecto.Changeset{data: %Establishment{}}

  """
  def change_establishment(%Establishment{} = establishment, attrs \\ %{}) do
    establishment |> Establishment.changeset(attrs)
  end
end
