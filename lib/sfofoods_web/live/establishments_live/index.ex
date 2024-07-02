defmodule MapexWeb.EstablishmentsLive.Index do
  use MapexWeb, :live_view

  alias Mapex.FoodPermits
  alias Mapex.FoodPermits.Establishments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :food_vendors, FoodPermits.list_food_vendors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Establishments")
    |> assign(:establishments, FoodPermits.get_establishments!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Establishments")
    |> assign(:establishments, %Establishments{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Food vendors")
    |> assign(:establishments, nil)
  end

  @impl true
  def handle_info({MapexWeb.EstablishmentsLive.FormComponent, {:saved, establishments}}, socket) do
    {:noreply, stream_insert(socket, :food_vendors, establishments)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    establishments = FoodPermits.get_establishments!(id)
    {:ok, _} = FoodPermits.delete_establishments(establishments)

    {:noreply, stream_delete(socket, :food_vendors, establishments)}
  end
end
