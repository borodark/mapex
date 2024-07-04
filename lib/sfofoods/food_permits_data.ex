defmodule Mapex.FoodPermitsData do
  use GenServer

  @moduledoc """
  The FoodPermitsData: gen_server with a dataframe
  """
  require Explorer.DataFrame, as: DataFrame
  require Explorer.Series, as: Series
  alias Mapex.FoodPermits.Establishment

  def start_link(arg) when is_binary(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def all do
    GenServer.call(__MODULE__, {:get_all})
  end

  def get!(object_id) do
    GenServer.call(__MODULE__, {:get, object_id})
  end

  def search(dish) do
    GenServer.call(__MODULE__, {:search, dish})
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
      |> IO.inspect()

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
  def handle_call({:search, dish}, _from, sfo_foods_data_frame) do
    establishments_serving_dishes =
      sfo_foods_data_frame
      |> DataFrame.filter_with(fn data_frame ->
        data_frame["fooditems"] |> Series.contains(dish)
      end)
      |> DataFrame.to_rows(atom_keys: true)
      |> Enum.map(fn one_vendor -> struct(%Establishment{}, one_vendor) end)

    {:reply, establishments_serving_dishes, sfo_foods_data_frame}
  end
end
