defmodule MapexWeb.EstablishmentsLive.Index do
  use MapexWeb, :live_view

  alias Mapex.FoodPermits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    # "calling handle_params" |> IO.inspect
    {:noreply,
     apply_action(
       socket |> stream(:food_vendors, FoodPermits.list_food_vendors()),
       socket.assigns.live_action,
       params
     )}
  end

  defp apply_action(socket, :index, _params) do
    # "calling apply_action" |> IO.inspect
    socket
    |> assign(:page_title, "Listing Food vendors")
  end
end
