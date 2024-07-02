defmodule Mapex.FoodPermits do
  @moduledoc """
  The FoodPermits context.
  """

  import Ecto.Query, warn: false
  alias Mapex.Repo

  alias Mapex.FoodPermits.Establishments

  @doc """
  Returns the list of food_vendors.

  ## Examples

      iex> list_food_vendors()
      [%Establishments{}, ...]

  """
  def list_food_vendors do
    Repo.all(Establishments)
  end

  @doc """
  Gets a single establishments.

  Raises `Ecto.NoResultsError` if the Establishments does not exist.

  ## Examples

      iex> get_establishments!(123)
      %Establishments{}

      iex> get_establishments!(456)
      ** (Ecto.NoResultsError)

  """
  def get_establishments!(id), do: Repo.get!(Establishments, id)

  @doc """
  Creates a establishments.

  ## Examples

      iex> create_establishments(%{field: value})
      {:ok, %Establishments{}}

      iex> create_establishments(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_establishments(attrs \\ %{}) do
    %Establishments{}
    |> Establishments.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a establishments.

  ## Examples

      iex> update_establishments(establishments, %{field: new_value})
      {:ok, %Establishments{}}

      iex> update_establishments(establishments, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_establishments(%Establishments{} = establishments, attrs) do
    establishments
    |> Establishments.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a establishments.

  ## Examples

      iex> delete_establishments(establishments)
      {:ok, %Establishments{}}

      iex> delete_establishments(establishments)
      {:error, %Ecto.Changeset{}}

  """
  def delete_establishments(%Establishments{} = establishments) do
    Repo.delete(establishments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking establishments changes.

  ## Examples

      iex> change_establishments(establishments)
      %Ecto.Changeset{data: %Establishments{}}

  """
  def change_establishments(%Establishments{} = establishments, attrs \\ %{}) do
    Establishments.changeset(establishments, attrs)
  end
end
