defmodule Mapex.FoodPermits do
  use GenServer

  @moduledoc """
  The FoodPermits: gen_server with a dataframe
  """
  require Explorer.DataFrame, as: DataFrame
  require Explorer.Series, as: Series

  alias Mapex.FoodPermits.Establishment

  @doc """
  Returns the list of food_vendors.

  ## Examples

  iex> list_food_vendors()
  [%Establishment{}, ...]

  """
  def list_food_vendors do
    GenServer.call(__MODULE__, {:get_all})
  end

  @doc """
  Gets a single establishment.

  ## Examples

  iex> get_establishment!(123)
  %Establishment{}

  iex> get_establishment!(456)
  ** (Ecto.NoResultsError)

  """
  def get_establishment!(object_id) when object_id |> is_number do
    GenServer.call(__MODULE__, {:get, object_id})
  end

  def get_establishment!(object_id) do
    GenServer.call(__MODULE__, {:get, object_id |> String.to_integer()})
  end

  @doc """
  Returns the list of food_vendors serving a particular dish.

  ## Examples

  iex> search_vendors_serving(dish)
  [%Establishment{}, ...]

  """
  def search_vendors_serving(dish, status) do
    GenServer.call(__MODULE__, {:search, dish, status})
  end

  def start_link(arg) when is_binary(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  #  \\ "sfo-street-foods.csv"
  @impl true
  def init(data_file_name) do
    {:ok, sfo_foods_data_frame} =
      data_file_name
      |> DataFrame.from_csv(
        columns: [
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
        ]
      )

    {:ok, sfo_foods_data_frame |> DataFrame.rename(objectid: :id)}
  end

  @impl true
  def handle_call({:get_all}, _from, sfo_foods_data_frame) do
    establishments =
      sfo_foods_data_frame
      |> DataFrame.to_rows(atom_keys: true)
      |> Enum.map(fn one_vendor -> struct(%Establishment{}, one_vendor) end)

    {:reply, establishments, sfo_foods_data_frame}
  end

  @impl true
  def handle_call({:get, id}, _from, sfo_foods_data_frame) do
    an_establishment =
      sfo_foods_data_frame
      |> DataFrame.filter(id == ^id)
      |> DataFrame.to_rows(atom_keys: true)
      |> Enum.at(0)

    {:reply, %Establishment{} |> struct(an_establishment), sfo_foods_data_frame}
  end

  @impl true
  def handle_call({:search_status, status}, _from, sfo_foods_data_frame) do
    establishments_in_status =
      sfo_foods_data_frame
      |> DataFrame.filter(status == ^status)
      |> DataFrame.to_rows(atom_keys: true)
      |> Enum.map(fn one_vendor -> %Establishment{} |> struct(one_vendor) end)

    {:reply, establishments_in_status, sfo_foods_data_frame}
  end

  @impl true
  def handle_call({:search, dish, status}, _from, sfo_foods_data_frame) do
    establishments_serving_dishes =
      sfo_foods_data_frame
      |> DataFrame.filter(status == ^status)
      |> DataFrame.filter_with(fn data_frame ->
        data_frame["fooditems"] |> Series.contains(dish)
      end)
      |> DataFrame.to_rows(atom_keys: true)
      |> Enum.map(fn one_vendor -> struct(%Establishment{}, one_vendor) end)

    {:reply, establishments_serving_dishes, sfo_foods_data_frame}
  end
end
