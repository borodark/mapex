defmodule MapexWeb.EstablishmentsLive.Show do
  use MapexWeb, :live_view

  alias Mapex.FoodPermits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:establishments, FoodPermits.get_establishment!(id))}
  end

  defp page_title(:show), do: "Show Establishments"
  defp page_title(:edit), do: "Edit Establishments"
end
