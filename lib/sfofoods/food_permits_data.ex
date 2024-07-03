defmodule Mapex.FoodPermitsData do
  use GenServer

  @moduledoc """
  The FoodPermitsData: gen_server with a dataframe
  """

  # alias Explorer.DataFrame
  # %Establishment{}
  require Explorer.DataFrame, as: DataFrame
  require Explorer.Series, as: Series
  alias Mapex.FoodPermits.Establishment

  def delete(%Establishment{} = delete_this) do
    GenServer.cast(__MODULE__, {:delete, delete_this})
  end

  def store(%Establishment{} = updated_or_new) do
    GenServer.cast(__MODULE__, {:store, updated_or_new})
  end

  def all do
    GenServer.call(__MODULE__, {:get_all})
  end

  def get!(object_id) do
    GenServer.call(__MODULE__, {:get, object_id})
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

    {:ok, sfo_foods_data_frame}
  end

  @impl true
  def handle_call(:get_all, _from, sfo_foods_data_frame) do
    establishments =
      sfo_foods_data_frame
      |> DataFrame.to_rows(atom_keys: true)
      |> Enum.map(fn one_vendor -> struct(%Establishment{}, one_vendor) end)

    {:reply, establishments, sfo_foods_data_frame}
  end

  @impl true
  def handle_call({:get, object_id}, _from, sfo_foods_data_frame) do
    an_establishment =
      sfo_foods_data_frame
      |> DataFrame.filter(objectid == ^object_id)
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
