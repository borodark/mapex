defmodule MapexWeb.EstablishmentLive.Index do
  use MapexWeb, :live_view

  alias Mapex.FoodPermits
  alias Mapex.FoodPermits.Establishment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :vendors, FoodPermits.list_vendors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Establishment")
    |> assign(:establishment, FoodPermits.get_establishment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Establishment")
    |> assign(:establishment, %Establishment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vendors")
    |> assign(:establishment, nil)
  end

  @impl true
  def handle_info({MapexWeb.EstablishmentLive.FormComponent, {:saved, establishment}}, socket) do
    {:noreply, stream_insert(socket, :vendors, establishment)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    establishment = FoodPermits.get_establishment!(id)
    {:ok, _} = FoodPermits.delete_establishment(establishment)

    {:noreply, stream_delete(socket, :vendors, establishment)}
  end
end
