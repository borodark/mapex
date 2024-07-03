defmodule Mapex.FoodPermitsData do
  use GenServer

  @moduledoc """
  The FoodPermitsData: gen_server with a dataframe
  """

  # alias Explorer.DataFrame
  # %Establishment{}
  require Explorer.DataFrame, as: DataFrame
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
  def handle_call(:get_all, from, sfo_foods_data_frame) do
    from |> IO.inspect()
    {:reply, sfo_foods_data_frame, sfo_foods_data_frame}
  end

  @impl true
  def handle_call({:get, object_id}, from, sfo_foods_data_frame) do
    from |> IO.inspect()

    establishments =
      sfo_foods_data_frame
      |> DataFrame.filter(objectid == ^object_id)
      |> DataFrame.to_rows(atom_keys: true)
      |> IO.inspect()

    an_establishment = establishments |> Enum.at(0)
    {:reply, %Establishment{} |> struct(an_establishment), sfo_foods_data_frame}
  end

  @impl true
  def handle_cast({:store, _this_one}, sfo_foods_data_frame) do
    # TODO implement store
    {:noreply, sfo_foods_data_frame}
  end

  @impl true
  def handle_cast({:delete, _delete_this}, sfo_foods_data_frame) do
    # TODO implement delete
    {:noreply, sfo_foods_data_frame}
  end
end
