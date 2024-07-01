defmodule Mapex.FoodPermits do
  @moduledoc """
  The FoodPermits context.
  # TODO Store in Dataset
  """

  alias Mapex.FoodPermits.Establishment

  @one_permit %Establishment{
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
  }

  import Ecto.Query, warn: false

  @doc """
  Returns the list of vendors.

  ## Examples

      iex> list_vendors()
      [%Establishment{}, ...]

  """
  def list_vendors do
    Repo.all(Establishment)
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
  def get_establishment!(id) do
    # TODO Store in Dataset
    %{@one_permit | objectid: id}
  end

  @doc """
  Creates a establishment.

  ## Examples

      iex> create_establishment(%{field: value})
      {:ok, %Establishment{}}

      iex> create_establishment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_establishment(attrs \\ %{}) do
    %Establishment{}
    |> Establishment.changeset(attrs)

    # |> Repo.insert()
    @one_permit
  end

  @doc """
  Updates a establishment.

  ## Examples

      iex> update_establishment(establishment, %{field: new_value})
      {:ok, %Establishment{}}

      iex> update_establishment(establishment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_establishment(%Establishment{} = establishment, attrs) do
    establishment
    |> Establishment.changeset(attrs)

    # |> Repo.update()
    # TODO Store in Dataset
    @one_permit
  end

  @doc """
  Deletes a establishment.

  ## Examples

      iex> delete_establishment(establishment)
      {:ok, %Establishment{}}

      iex> delete_establishment(establishment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_establishment(%Establishment{} = establishment) do
    # Repo.delete(establishment)
    @one_permit
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking establishment changes.

  ## Examples

      iex> change_establishment(establishment)
      %Ecto.Changeset{data: %Establishment{}}

  """
  def change_establishment(%Establishment{} = establishment, attrs \\ %{}) do
    Establishment.changeset(establishment, attrs)
  end
end
